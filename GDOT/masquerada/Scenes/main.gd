extends Node3D

class_name MainRoom

@onready var menu = $Control as MainMenu

@onready var table = $Table as Table

@onready var AttackHanger = $MeshInstance3D/AttackMaskHanger1
@onready var DefenseHanger = $MeshInstance3D/DefenseMaskHanger1

var Plr = PhysicalPlayer.new()
var CPU = ComputerPlayer.new(self)

var WinScreen = preload("res://Scenes/GameOver/Win.tscn")
var DrawScreen = preload("res://Scenes/GameOver/Draw.tscn")
var LossScreen = preload("res://Scenes/GameOver/Lose.tscn")

func HangAttackMask():
	Plr.GetAttackMask().mesh.top_level = false
	Plr.GetAttackMask().mesh.reparent(AttackHanger)
	Plr.GetAttackMask().mesh.transform = Transform3D.IDENTITY
	print("Transformed")
	
func HangDefenseMask():
	Plr.GetDefenseMask().mesh.top_level = false
	Plr.GetDefenseMask().mesh.reparent(DefenseHanger)
	Plr.GetDefenseMask().mesh.transform = Transform3D.IDENTITY

func StartGame():
	add_child(Plr)
	add_child(CPU)
	Plr.EquippedAttack.connect(HangAttackMask)
	Plr.EquippedDefense.connect(HangDefenseMask)
	var CurrentGame = await RoundManager.Game(Plr,CPU,table)
	if CurrentGame == "Win": add_child(WinScreen.instantiate())
	elif CurrentGame == "Draw": add_child(DrawScreen.instantiate())
	else: add_child(LossScreen.instantiate())
	
func _ready() -> void:
	menu.find_child("Play").button_down.connect(StartGame)
