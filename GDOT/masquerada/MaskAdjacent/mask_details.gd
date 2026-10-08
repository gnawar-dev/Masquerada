extends Control

class_name MaskDetails

@onready var NameLabel = $VBoxContainer/TopBar/NameLabel

@onready var DurationIcons = $VBoxContainer/TopBar/Duration/Instance

@onready var AttackDescription = $VBoxContainer/ChoiceBar/AttackDescription
@onready var DefenseDescription = $VBoxContainer/ChoiceBar/DefenseDescription

var mask:Mask

func _ready() -> void:
	mask = get_parent() as Mask
	
	NameLabel.text = mask.name
	AttackDescription.find_child("Desc").text = mask.AttackDescription
	DefenseDescription.find_child("Desc").text = mask.DefenseDescription
	
	Disappear()

func Appear():
	visible = true
	Update()
	
	
func Disappear():
	visible = false

func _GetCurrentAD():
	return mask.Wearer.GetAttackMask().AttackDescription
	
func _GetCurrentDD():
	return mask.Wearer.GetDefenseMask().DefenseDescription

func Update():
	if mask.Wearer.GetAttackMask() != null: 
		AttackDescription.disabled = true
		AttackDescription.find_child("Lock").visible = true
		AttackDescription.find_child("Desc").text = _GetCurrentAD()
		
	if mask.Wearer.GetDefenseMask() != null:
		DefenseDescription.disabled = true
		DefenseDescription.find_child("Lock").visible = true
		DefenseDescription.find_child("Desc").text = _GetCurrentDD()
	
	

func AttackSelected() -> void:
	mask.Wearer.EquipAttackMask(mask)
	


func DefenseSelected() -> void:
	mask.Wearer.EquipDefenseMask(mask)
	


func Exit() -> void:
	Disappear()
