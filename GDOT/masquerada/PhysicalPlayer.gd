extends Player
class_name PhysicalPlayer
var narr: Narrator
func _ready() -> void:
	narr = preload("res://narrator.tscn").instantiate()
	add_child(narr)
	super._ready()

func Attack():
	super.Attack()
	narr.DisplayResult(OppDef,Efficacy)
