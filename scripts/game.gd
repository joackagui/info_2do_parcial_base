extends Node2D

@onready var grid = $grid
@onready var top_ui = $top_ui
@onready var game_timer = $game_timer
@onready var game_theme = $GameTheme
@onready var game_lost = $game_over
@onready var game_won = $game_won
@onready var bottom_buttom = $bottom_button

var level: int = 1
var goal: int = 2000
var time_mode: bool = true

func _ready():
	game_theme.play()
	game_theme.volume_db = -20
	game_lost.visible = false
	game_won.visible = false

	level = GameManager.level
	time_mode = GameManager.time_mode
	goal = GameManager.goal
	grid.add_score.connect(on_add_score)
	
	var level_goal = 5000 + 1000 * level
	goal = level_goal
	top_ui.set_goal(level_goal)
	
	if time_mode:
		var level_time = 200 - 15 * level
		top_ui.set_timer(level_time)
		game_timer.start()
	else:
		grid.reduce_counter.connect(on_reduce_counter)
		var level_counter = 90 - 10 * level
		top_ui.set_counter(level_counter)
		game_timer.stop()
	top_ui.update_labels()

func on_add_score(points: int):
	top_ui.current_score += points
	top_ui.update_labels()

func on_reduce_counter():
	top_ui.current_count -= 1
	top_ui.update_labels()
	_check_end_game()

func _on_game_timer_timeout():
	top_ui.current_time -= 1
	top_ui.update_labels()

	if top_ui.current_time <= 0:
		_game_over()
	if top_ui.current_score >= goal:
		_game_won()

func _check_end_game():
	if top_ui.current_count <= 0:
		_game_over()
	if top_ui.current_score >= goal:
		_game_won()

func _game_over():
	game_timer.stop()
	grid.state = grid.WAIT
	game_lost.visible = true
	print("GAME OVER")

func _game_won():
	if GameManager.time_mode:
		if level == 1:
			GameManager.level1_time_passed = true
			GameManager.level2_time_blocked = false
		if level == 2:
			GameManager.level2_time_passed = true
			GameManager.level3_time_blocked = false
		if level == 3:
			GameManager.level3_time_passed = true
			GameManager.level4_time_blocked = false
		if level == 4:
			GameManager.level4_time_passed = true
			GameManager.level5_time_blocked = false
		if level == 5:
			GameManager.level5_time_passed = true
			GameManager.level6_time_blocked = false
		if level == 6:
			GameManager.level6_time_passed = true
	else:
		if level == 1:
			GameManager.level1_attempt_passed = true
			GameManager.level2_attempt_blocked = false
		if level == 2:
			GameManager.level2_attempt_passed = true
			GameManager.level3_attempt_blocked = false
		if level == 3:
			GameManager.level3_attempt_passed = true
			GameManager.level4_attempt_blocked = false
		if level == 4:
			GameManager.level4_attempt_passed = true
			GameManager.level5_attempt_blocked = false
		if level == 5:
			GameManager.level5_attempt_passed = true
			GameManager.level6_attempt_blocked = false
		if level == 6:
			GameManager.level6_attempt_passed = true
		
	game_won.visible = true

func _on_bottom_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_selection.tscn")

func _on_bottom_button_mouse_entered() -> void:
	bottom_buttom.scale = Vector2(1, 1)

func _on_bottom_button_mouse_exited() -> void:
	bottom_buttom.scale = Vector2(0.8, 0.8)
