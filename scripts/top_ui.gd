extends TextureRect

@onready var score_label = $MarginContainer/HBoxContainer/score_label
@onready var counter_label = $MarginContainer/HBoxContainer/counter_label
@onready var timer_label = $MarginContainer/HBoxContainer/timer_label

@export var current_score: int = 0
@export var current_count: int = 20
@export var current_time: int = 100

func _ready() -> void:
	update_labels()

func update_labels():
	score_label.text = str(current_score)
	counter_label.text = str(current_count)
	timer_label.text = str(current_time)
