extends Node2D

@onready var main_menu_button = $main_menu_button
@onready var next_level_button = $next_level_button
	
func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
func _on_next_level_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_selection.tscn")

# Hovering
func _on_main_menu_button_mouse_entered() -> void:
	main_menu_button.scale = Vector2(0.15, 0.15)

func _on_main_menu_button_mouse_exited() -> void:
	main_menu_button.scale = Vector2(0.12, 0.12)

func _on_next_level_button_mouse_entered() -> void:
	next_level_button.scale = Vector2(0.15, 0.15)

func _on_next_level_button_mouse_exited() -> void:
	next_level_button.scale = Vector2(0.12, 0.12)
