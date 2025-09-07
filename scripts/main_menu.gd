extends Node2D

@onready var levels_button = $levels_button
@onready var exit_button = $exit_button

var next_level = 1
var time_mode: bool = true

func _on_next_level_button_pressed() -> void:
	var game_scene = preload("res://scenes/game.tscn").instantiate()
	game_scene.level = next_level
	game_scene.time_mode = time_mode
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_levels_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_selection.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_levels_button_mouse_entered() -> void:
	levels_button.scale = Vector2(1, 1)

func _on_levels_button_mouse_exited() -> void:
	levels_button.scale = Vector2(0.8, 0.8)

func _on_exit_button_mouse_entered() -> void:
	exit_button.scale = Vector2(1, 1)

func _on_exit_button_mouse_exited() -> void:
	exit_button.scale = Vector2(0.8, 0.8)
