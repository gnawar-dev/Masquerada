extends Control

class_name MainMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Called when the user presses the play button
func _on_play_button_up() -> void:
	# Start the game
	# Go to initial scene
	visible = false

# Called when the user presses the quit button
func _on_quit_button_up() -> void:
	# Exit the game
	get_tree().quit()

# Called when the user presses the credits button
func _on_credits_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/Credits.tscn")
