extends Node2D

@onready var return_button = $retun_button

func _ready() -> void:
	return_button.connect("pressed", _on_return_pressed)
	
	return_button.connect("mouse_entered", _on_button_mouse_entered.bind(return_button))
	return_button.connect("mouse_exited", _on_button_mouse_exited.bind(return_button))

func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_button_mouse_entered(button: TextureButton) -> void:
	button.scale = Vector2(1.2, 1.2)

func _on_button_mouse_exited(button: TextureButton) -> void:
	button.scale = Vector2(1, 1)
