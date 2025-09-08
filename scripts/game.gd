extends Node2D

@onready var grid = $grid
@onready var top_ui = $top_ui
@onready var game_timer = $game_timer

var level: int = 1
var goal: int = 2000
var time_mode: bool = true

func _ready():
	level = GameManager.level
	time_mode = GameManager.time_mode
	goal = GameManager.goal

	grid.add_score.connect(on_add_score)
	
	var level_goal = 5000 + 2000 * level
	goal = level_goal
	top_ui.set_goal(level_goal)
	
	if time_mode:
		var level_time = 200 - 15 * level
		top_ui.set_timer(level_time)
		game_timer.start()
	else:
		grid.reduce_counter.connect(on_reduce_counter)
		var level_counter = 100 - 10 * level
		top_ui.set_counter(level_counter)
		game_timer.stop()

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

func _check_end_game():
	if top_ui.current_count <= 0:
		_game_over()
	if top_ui.current_score >= goal:
		_game_won()

func _game_over():
	game_timer.stop()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	grid.state = grid.WAIT
	print("GAME OVER")

func _game_won():
	if level == 1:
		GameManager.level1_passed = true
		GameManager.level2_blocked = false
	if level == 2:
		GameManager.level2_passed = true
		GameManager.level3_blocked = false
	if level == 3:
		GameManager.level3_passed = true
		GameManager.level4_blocked = false
	if level == 4:
		GameManager.level4_passed = true
		GameManager.level5_blocked = false
	if level == 5:
		GameManager.level5_passed = true
		GameManager.level6_blocked = false
	if level == 6:
		GameManager.level6_passed = true
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
