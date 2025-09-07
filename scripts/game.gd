extends Node2D

@onready var grid = $grid
@onready var top_ui = $top_ui
@onready var game_timer = $game_timer

var level: int = 1

func _ready():
	grid.add_score.connect(on_add_score) 
	grid.reduce_counter.connect(on_reduce_counter)

	game_timer.start()

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

func _game_over():
	game_timer.stop()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	grid.state = grid.WAIT
	print("GAME OVER")
