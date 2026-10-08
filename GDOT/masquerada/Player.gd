extends Node
class_name Player

@export var Health := 100

var AbsorbedTurnDamage:int = 0

var Opponent: Player

var EquippedAttackMask: Mask
var EquippedDefenseMask: Mask

var HealthBar: Healthbar

func _ready() -> void:
	HealthBar = load("res://healthbar.tscn").instantiate()
	add_child(HealthBar)
	
func _UpdateHealthBar():
	HealthBar.Bar.value = Health
	if Opponent != null:
		HealthBar.OpponentBar.value = Opponent.GetHealth()

func GetAttackMask(): return EquippedAttackMask
func GetDefenseMask(): return EquippedDefenseMask

func GetHealth(): return Health

func GetOpponent(): return Opponent

# locks two players as opponents
func SetOpponent(Enemy:Player):
	Opponent = Enemy
	if Enemy.GetOpponent() == null: Enemy.SetOpponent(self)

# equips the given mask in attack mode
signal EquippedAttack
func EquipAttackMask(mask:Mask):
	EquippedAttackMask = mask
	EquippedAttack.emit()

# equips the given mask in defense mode
signal EquippedDefense
func EquipDefenseMask(mask:Mask):
	EquippedDefenseMask = mask
	EquippedDefense.emit()

func HasChosen():
	var atk = EquippedAttackMask != null
	var def = EquippedDefenseMask != null
	return atk and def

# makes the player lose health equal to dmg
func TakeDamage(dmg:int):
	AbsorbedTurnDamage += dmg
	Health -= dmg
	if Health < 0: Health = 0
	_UpdateHealthBar()

func Heal(hp:int):
	Health += hp
	_UpdateHealthBar()

func GetSustainedDamage(): return AbsorbedTurnDamage

# runs at the end of the attack phase
func  FinalizeTurn():
	AbsorbedTurnDamage = 0

# triggers the defense masks's effect
func Defend():
	EquippedDefenseMask.Defend()

# skips the defense masks's effect
func Break():
	EquippedDefenseMask.Break()

# use the attack mask on the opponent
signal SuperEffective
signal Stagger
signal Defended
var OppDef:String
var Efficacy:String
func Attack():
	var OppDefenseType = Opponent.GetDefenseMask().GetType()
	OppDef = Opponent.GetDefenseMask().name
	
	var ExplosiveAttackType = EquippedAttackMask.GetType()
	var PerfectAttackType = MaskTypes.InferiorOf(EquippedAttackMask.GetType())
	
	match OppDefenseType:
		#Super-effective attack, breaks defense
		PerfectAttackType:
			EquippedAttackMask.PrimaryAttack();
			Opponent.Break()
			Efficacy = "Super Effective"
		
		#Clash Attack, Weaker attack but breaks defense
		ExplosiveAttackType:
			EquippedAttackMask.SecondaryAttack()
			Opponent.Break()
			Efficacy = "Staggering"
		
		# Standard Attack, defended
		_: 
			EquippedAttackMask.SecondaryAttack()
			Opponent.Defend()
			Efficacy = "Defended"
