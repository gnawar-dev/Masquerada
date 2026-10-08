extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Called when Play Again is pressed
func _on_play_again_button_up() -> void:
	visible = false

# Called when Quit to Main Menu is pressed
func _on_quit_to_main_menu_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
