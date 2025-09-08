extends Node2D

@onready var replay_button = $replay_button
@onready var main_menu_button = $main_menu_button

func _on_replay_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	
func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

# Hovering
func _on_replay_button_mouse_entered() -> void:
	replay_button.scale = Vector2(0.15, 0.15)

func _on_replay_button_mouse_exited() -> void:
	replay_button.scale = Vector2(0.12, 0.12)

func _on_main_menu_button_mouse_entered() -> void:
	main_menu_button.scale = Vector2(0.15, 0.15)

func _on_main_menu_button_mouse_exited() -> void:
	main_menu_button.scale = Vector2(0.12, 0.12)
