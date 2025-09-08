extends TextureRect

@onready var score_label = $MarginContainer/HBoxContainer/score_label
@onready var count_label = $MarginContainer/HBoxContainer/count_label
@onready var goal_label = $MarginContainer/HBoxContainer/goal_label

@export var current_score: int = 0
@export var current_count: int = 0
@export var current_time: int = 0
@export var goal_to_reach: int = 0
@export var time_mode: bool = true

func _ready() -> void:
	update_labels()

func update_labels():
	score_label.text = "Score: \n" + str(current_score)
	if time_mode:
		count_label.text = str(current_count)
	else:
		count_label.text = str(current_time)
	goal_label.text = "Goal: \n " + str(goal_to_reach)

func set_timer(time: int):
	current_time = time
	
func set_counter(counter: int):
	current_count = counter

func set_time_mode(mode: bool):
	time_mode = mode

func set_goal(goal: int):
	goal_to_reach = goal
