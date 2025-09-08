extends Node2D

@onready var return_button = $return_button
@onready var level1_button = $button_level1
@onready var level2_button = $button_level2
@onready var level3_button = $button_level3
@onready var level4_button = $button_level4
@onready var level5_button = $button_level5
@onready var level6_button = $button_level6
@onready var mode_button = $mode_button
@onready var mode_label = $mode_button/mode_label

@export var time_mode: bool = false
@export var level_time: int = 1
@export var level_counter: bool = 1

func _ready() -> void:
	update_mode()
	
	
func _on_retun_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_button_level_1_pressed() -> void:
	change_to_game(1)

func _on_button_level_2_pressed() -> void:
	change_to_game(2)

func _on_button_level_3_pressed() -> void:
	change_to_game(3)

func _on_button_level_4_pressed() -> void:
	change_to_game(4)

func _on_button_level_5_pressed() -> void:
	change_to_game(5)

func _on_button_level_6_pressed() -> void:
	change_to_game(6)
	
func _on_mode_button_pressed() -> void:
	time_mode = !time_mode
	GameManager.time_mode = time_mode
	update_mode()
	
func change_to_game(game_level: int):
	GameManager.level = game_level
	GameManager.time_mode = time_mode
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func update_mode():
	time_mode = GameManager.time_mode
	if time_mode:
		mode_label.text = "Mode: Time"
	else:
		mode_label.text = "Mode: Attempts"

	var default_color = Color(1, 1, 1, 1)
	var buttons = [level1_button, level2_button, level3_button, level4_button, level5_button, level6_button]
	for b in buttons:
		b.modulate = default_color
		b.disabled = false

	if time_mode:
		if GameManager.level1_time_passed:
			level1_button.modulate = Color(1.2, 1, 0, 1)
		if GameManager.level2_time_passed:
			level2_button.modulate = Color(1.2, 1, 0, 1)
		if GameManager.level3_time_passed:
			level3_button.modulate = Color(1.2, 1, 0, 1)
		if GameManager.level4_time_passed:
			level4_button.modulate = Color(1.2, 1, 0, 1)
		if GameManager.level5_time_passed:
			level5_button.modulate = Color(1.2, 1, 0, 1)
		if GameManager.level6_time_passed:
			level6_button.modulate = Color(1.2, 1, 0, 1)

		if GameManager.level2_time_blocked:
			level2_button.modulate = Color(0.5, 0.5, 0.5, 0.5)
			level2_button.disabled = true
		if GameManager.level3_time_blocked:
			level3_button.modulate = Color(0.5, 0.5, 0.5, 0.5)
			level3_button.disabled = true
		if GameManager.level4_time_blocked:
			level4_button.modulate = Color(0.5, 0.5, 0.5, 0.5)
			level4_button.disabled = true
		if GameManager.level5_time_blocked:
			level5_button.modulate = Color(0.5, 0.5, 0.5, 0.5)
			level5_button.disabled = true
		if GameManager.level6_time_blocked:
			level6_button.modulate = Color(0.5, 0.5, 0.5, 0.5)
			level6_button.disabled = true
	else:
		if GameManager.level1_attempt_passed:
			level1_button.modulate = Color(1.2, 1, 0, 1)
		if GameManager.level2_attempt_passed:
			level2_button.modulate = Color(1.2, 1, 0, 1)
		if GameManager.level3_attempt_passed:
			level3_button.modulate = Color(1.2, 1, 0, 1)
		if GameManager.level4_attempt_passed:
			level4_button.modulate = Color(1.2, 1, 0, 1)
		if GameManager.level5_attempt_passed:
			level5_button.modulate = Color(1.2, 1, 0, 1)
		if GameManager.level6_attempt_passed:
			level6_button.modulate = Color(1.2, 1, 0, 1)

		if GameManager.level2_attempt_blocked:
			level2_button.modulate = Color(0.5, 0.5, 0.5, 0.5)
			level2_button.disabled = true
		if GameManager.level3_attempt_blocked:
			level3_button.modulate = Color(0.5, 0.5, 0.5, 0.5)
			level3_button.disabled = true
		if GameManager.level4_attempt_blocked:
			level4_button.modulate = Color(0.5, 0.5, 0.5, 0.5)
			level4_button.disabled = true
		if GameManager.level5_attempt_blocked:
			level5_button.modulate = Color(0.5, 0.5, 0.5, 0.5)
			level5_button.disabled = true
		if GameManager.level6_attempt_blocked:
			level6_button.modulate = Color(0.5, 0.5, 0.5, 0.5)
			level6_button.disabled = true

# Hovering
func _on_retun_button_mouse_entered() -> void:
	return_button.scale = Vector2(1, 1)

func _on_retun_button_mouse_exited() -> void:
	return_button.scale = Vector2(0.8, 0.8)

func _on_button_level_1_mouse_entered() -> void:
	level1_button.scale = Vector2(0.2, 0.2)

func _on_button_level_1_mouse_exited() -> void:
	level1_button.scale = Vector2(0.15, 0.15)
	
func _on_button_level_2_mouse_entered() -> void:
	if not level2_button.disabled:
		level2_button.scale = Vector2(0.2, 0.2)

func _on_button_level_2_mouse_exited() -> void:
	level2_button.scale = Vector2(0.15, 0.15)
		
func _on_button_level_3_mouse_entered() -> void:
	if not level3_button.disabled:
		level3_button.scale = Vector2(0.2, 0.2)
	
func _on_button_level_3_mouse_exited() -> void:
	level3_button.scale = Vector2(0.15, 0.15)
	
func _on_button_level_4_mouse_entered() -> void:
	if not level4_button.disabled:
		level4_button.scale = Vector2(0.2, 0.2)	
	
func _on_button_level_4_mouse_exited() -> void:
		level4_button.scale = Vector2(0.15, 0.15)	
	
func _on_button_level_5_mouse_entered() -> void:
	if not level5_button.disabled:
		level5_button.scale = Vector2(0.2, 0.2)
		
func _on_button_level_5_mouse_exited() -> void:
	level5_button.scale = Vector2(0.15, 0.15)	

func _on_button_level_6_mouse_entered() -> void:
	if not level6_button.disabled:
		level6_button.scale = Vector2(0.2, 0.2)
		
func _on_button_level_6_mouse_exited() -> void:
	level6_button.scale = Vector2(0.15, 0.15)	

func _on_mode_button_mouse_entered() -> void:
	mode_button.scale = Vector2(1, 1)	

func _on_mode_button_mouse_exited() -> void:
	mode_button.scale = Vector2(0.8, 0.8)	
