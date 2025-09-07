extends TextureRect

@onready var score_label = $MarginContainer/HBoxContainer/score_label
@onready var counter_label = $MarginContainer/HBoxContainer/counter_label
@onready var timer_label = $MarginContainer/HBoxContainer/timer_label

@export var current_score: int = 0
@export var current_count: int = 0
@export var current_time: int = 0

func _ready() -> void:
	update_labels()

func update_labels():
	score_label.text = str(current_score)
	counter_label.text = str(current_count)
	timer_label.text = str(current_time)
	
func set_timer(time: int):
	current_time = time
	
func set_counter(counter: int):
	current_count = counter
	
func hide_timer():
	timer_label.hide()
	
func hide_counter():
	counter_label.hide()
