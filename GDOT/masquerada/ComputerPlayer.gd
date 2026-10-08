extends Player
class_name ComputerPlayer

var BRChance = 0.2
var STChance = 0.4
var NMChance: float

var DifficultyScale = 1.0

var Room:MainRoom

func ApplyDifficultyScale():
	BRChance -= 0.15 * DifficultyScale
	STChance -= 0.2 * DifficultyScale
	NMChance = 1 - BRChance - STChance
	
func _init(r:MainRoom) -> void:
	Room = r

func _ready() -> void:
	super._ready()
	HealthBar.visible = false

var AvailableMasks: Array
var UnavailableMasks: Array
var OpponentAttack: Mask
var OpponentDefense: Mask

func Scan():
	AvailableMasks = Room.table.Side2.get_children() as Array[Mask]
	OpponentAttack = (Room.AttackHanger.get_children()[0] as MaskMesh).mask
	OpponentDefense = (Room.DefenseHanger.get_children()[0] as MaskMesh).mask

func ForgetUnavailableMasks():
	for i in UnavailableMasks:
		if AvailableMasks.has(i): AvailableMasks.erase(i)

func FindAttackCounter():
	print(1)
	var CounterFound = false
	for i in AvailableMasks:
		if MaskTypes.InferiorOf(i.GetType()) == OpponentDefense.GetType():
			CounterFound = true
			EquipAttackMask(i)
			UnavailableMasks.append(i)
			break
	ForgetUnavailableMasks()
	if CounterFound: return
	else: FindAttackStagger()
	
func FindDefenseCounter():
	print(1)
	var CounterFound = false
	for i in AvailableMasks:
		if MaskTypes.InferiorOf(i.GetType()) == OpponentAttack.GetType():
			CounterFound = true
			EquipDefenseMask(i)
			UnavailableMasks.append(i)
			break
	ForgetUnavailableMasks()
	if CounterFound: return
	else: FindDefenseStagger()

func FindAttackStagger():
	print(2)
	var StaggerFound = false
	for i in AvailableMasks:
		if i.GetType() == OpponentDefense.GetType():
			StaggerFound = true
			EquipAttackMask(i)
			UnavailableMasks.append(i)
			break
	ForgetUnavailableMasks()
	if StaggerFound: return
	else: ChooseAttackRandomly()

func FindDefenseStagger():
	print(2)
	var StaggerFound = false
	for i in AvailableMasks:
		if i.GetType() == OpponentDefense.GetType():
			StaggerFound = true
			EquipDefenseMask(i)
			UnavailableMasks.append(i)
			break
	ForgetUnavailableMasks()
	if StaggerFound: return
	else: ChooseDefenseRandomly()

func ChooseAttackRandomly():
	#print(3)
	print(AvailableMasks)
	var ChosenMask = AvailableMasks.pick_random()
	EquipAttackMask(ChosenMask)
	
func ChooseDefenseRandomly():
	print(3)
	var ChosenMask = AvailableMasks.pick_random()
	EquipDefenseMask(ChosenMask)

func ChooseAttack():
	var ran = randf()
	if ran >= 1-BRChance: FindAttackCounter()
	elif  ran >= 1-(BRChance+STChance): FindAttackStagger()
	else: ChooseAttackRandomly()
	print("HasAttack")

func ChooseDefense():
	var ran = randf()
	if ran >= 1-BRChance: FindDefenseCounter()
	elif  ran >= 1-(BRChance+STChance): FindDefenseStagger()
	else: ChooseDefenseRandomly()
	print("HasDefense")
	
func FinalizeChoice():
	UnavailableMasks.clear()
	AvailableMasks.clear()
