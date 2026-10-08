extends Control

class_name Narrator

@onready var Narration = $RichTextLabel

func DisplayResult(AttackName, Efficacy):
	Narration.text = AttackName + " - " + Efficacy
