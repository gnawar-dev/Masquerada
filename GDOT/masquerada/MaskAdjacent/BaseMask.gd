extends Node
class_name Mask

@export var mesh:MaskMesh

@export var Duration: int

@export var MaskType: MaskTypes.ENUM

@export_multiline() var AttackDescription: String

@export_multiline() var DefenseDescription: String

@onready var Details: MaskDetails

var Wearer:Player

func GetType(): return MaskType

func WearOn(nWearer:Player):
	Wearer = nWearer
	RoundManager.RoundTick.connect(MaskRoundTick)

func GetWearer(): return Wearer

func destroy():
	print("Destroying")
	if RoundManager.RoundTick.is_connected(MaskRoundTick):
		RoundManager.RoundTick.disconnect(MaskRoundTick)
	if Wearer.GetAttackMask() == self: Wearer.EquippedAttackMask = null
	if Wearer.GetDefenseMask() == self: Wearer.EquippedDefenseMask = null
	mesh.queue_free()
	queue_free()



func PrimaryAttack():
	pass
	
func SecondaryAttack():
	pass
	
func Defend():
	Break()

func Break():
	Duration = 1

func TickFunc():
	pass

func MaskRoundTick():
	Duration -= 1
	print(Duration)
	if Duration < 1:
		destroy()
	else: TickFunc()

func _ready() -> void:
	Details = preload("res://MaskAdjacent/MaskDetails.tscn").instantiate()
	add_child(Details)
	## later there will be code to have the mask appear on the table,
	## with the ability for them to be chosen
