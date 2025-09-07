extends Node2D

@onready var next_level_button = $next_level_button
@onready var levels_button = $levels_button
@onready var exit_button = $exit_button

var next_level = 1

func _ready() -> void:
	next_level_button.connect("pressed", _on_next_level_pressed)
	levels_button.connect("pressed", _on_levels_pressed)
	exit_button.connect("pressed", _on_exit_pressed)

	next_level_button.connect("mouse_entered", _on_button_mouse_entered.bind(next_level_button))
	next_level_button.connect("mouse_exited", _on_button_mouse_exited.bind(next_level_button))

	levels_button.connect("mouse_entered", _on_button_mouse_entered.bind(levels_button))
	levels_button.connect("mouse_exited", _on_button_mouse_exited.bind(levels_button))

	exit_button.connect("mouse_entered", _on_button_mouse_entered.bind(exit_button))
	exit_button.connect("mouse_exited", _on_button_mouse_exited.bind(exit_button))

func _on_next_level_pressed() -> void:
	print("Ir al nivel:", next_level)
	var game_scene = preload("res://scenes/game.tscn").instantiate()
	game_scene.level = next_level
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_levels_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_selection.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_button_mouse_entered(button: TextureButton) -> void:
	button.scale = Vector2(1.2, 1.2)

func _on_button_mouse_exited(button: TextureButton) -> void:
	button.scale = Vector2(1, 1)
