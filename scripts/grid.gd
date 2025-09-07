extends Node2D

# state machine
enum {WAIT, MOVE}
var state

# grid
@export var width: int
@export var height: int
@export var x_start: int
@export var y_start: int
@export var offset: int
@export var y_offset: int

# piece array
var possible_pieces = [
	preload("res://scenes/blue_piece.tscn"),
	preload("res://scenes/green_piece.tscn"),
	preload("res://scenes/light_green_piece.tscn"),
	preload("res://scenes/pink_piece.tscn"),
	preload("res://scenes/yellow_piece.tscn"),
	preload("res://scenes/orange_piece.tscn"),
]
# current pieces in scene
var all_pieces = []

# swap back
var piece_one = null
var piece_two = null
var last_place = Vector2.ZERO
var last_direction = Vector2.ZERO
var move_checked = false

# touch variables
var first_touch = Vector2.ZERO
var final_touch = Vector2.ZERO
var is_controlling = false

# signals
signal add_score(points: int)
signal reduce_counter()

# Called when the node enters the scene tree for the first time.
func _ready():
	state = MOVE
	randomize()
	all_pieces = make_2d_array()
	spawn_pieces()

func make_2d_array():
	var array = []
	for i in width:
		array.append([])
		for j in height:
			array[i].append(null)
	return array
	
func grid_to_pixel(column, row):
	var new_x = x_start + offset * column
	var new_y = y_start - offset * row
	return Vector2(new_x, new_y)
	
func pixel_to_grid(pixel_x, pixel_y):
	var new_x = round((pixel_x - x_start) / offset)
	var new_y = round((pixel_y - y_start) / -offset)
	return Vector2(new_x, new_y)
	
func in_grid(column, row):
	return column >= 0 and column < width and row >= 0 and row < height
	
func spawn_pieces():
	for i in width:
		for j in height:
			# random number
			var rand = randi_range(0, possible_pieces.size() - 1)
			# instance 
			var piece = possible_pieces[rand].instantiate()
			# repeat until no matches
			var max_loops = 100
			var loops = 0
			while (match_at(i, j, piece.color) and loops < max_loops):
				rand = randi_range(0, possible_pieces.size() - 1)
				loops += 1
				piece = possible_pieces[rand].instantiate()
			add_child(piece)
			piece.position = grid_to_pixel(i, j)
			# fill array with pieces
			all_pieces[i][j] = piece

func match_at(i, j, color):
	# check left
	if i > 1:
		if all_pieces[i - 1][j] != null and all_pieces[i - 2][j] != null:
			if all_pieces[i - 1][j].color == color and all_pieces[i - 2][j].color == color:
				return true
	# check down
	if j> 1:
		if all_pieces[i][j - 1] != null and all_pieces[i][j - 2] != null:
			if all_pieces[i][j - 1].color == color and all_pieces[i][j - 2].color == color:
				return true

func touch_input():
	var mouse_pos = get_global_mouse_position()
	var grid_pos = pixel_to_grid(mouse_pos.x, mouse_pos.y)
	if Input.is_action_just_pressed("ui_touch") and in_grid(grid_pos.x, grid_pos.y):
		first_touch = grid_pos
		is_controlling = true
		
	# release button
	if Input.is_action_just_released("ui_touch") and in_grid(grid_pos.x, grid_pos.y) and is_controlling:
		is_controlling = false
		final_touch = grid_pos
		touch_difference(first_touch, final_touch)

func swap_pieces(column, row, direction: Vector2):
	var first_piece = all_pieces[column][row]
	var other_piece = all_pieces[column + direction.x][row + direction.y]
	if first_piece == null or other_piece == null:
		return
	# swap
	state = WAIT
	store_info(first_piece, other_piece, Vector2(column, row), direction)
	all_pieces[column][row] = other_piece
	all_pieces[column + direction.x][row + direction.y] = first_piece
	#first_piece.position = grid_to_pixel(column + direction.x, row + direction.y)
	#other_piece.position = grid_to_pixel(column, row)
	first_piece.move(grid_to_pixel(column + direction.x, row + direction.y))
	other_piece.move(grid_to_pixel(column, row))
	if not move_checked:
		find_matches()

func store_info(first_piece, other_piece, place, direction):
	piece_one = first_piece
	piece_two = other_piece
	last_place = place
	last_direction = direction

func swap_back():
	if piece_one != null and piece_two != null:
		swap_pieces(last_place.x, last_place.y, last_direction)
	state = MOVE
	move_checked = false

func touch_difference(grid_1, grid_2):
	var difference = grid_2 - grid_1
	# should move x or y?
	if abs(difference.x) > abs(difference.y):
		if difference.x > 0:
			swap_pieces(grid_1.x, grid_1.y, Vector2(1, 0))
		elif difference.x < 0:
			swap_pieces(grid_1.x, grid_1.y, Vector2(-1, 0))
	if abs(difference.y) > abs(difference.x):
		if difference.y > 0:
			swap_pieces(grid_1.x, grid_1.y, Vector2(0, 1))
		elif difference.y < 0:
			swap_pieces(grid_1.x, grid_1.y, Vector2(0, -1))

func _process(_delta):
	if state == MOVE:
		touch_input()

func find_matches(moved_piece: Node2D = null):
	var isfiveR = false
	var isfiveC = false
	for i in width:
		for j in height:
			if all_pieces[i][j] == null:
				continue
				
			var current_color = all_pieces[i][j].color
			# Combinación de 5
			if i <= width - 5 and \
			all_pieces[i+1][j] != null and all_pieces[i+1][j].color == current_color and \
			all_pieces[i+2][j] != null and all_pieces[i+2][j].color == current_color and \
			all_pieces[i+3][j] != null and all_pieces[i+3][j].color == current_color and \
			all_pieces[i+4][j] != null and all_pieces[i+4][j].color == current_color:
				
				var pieces_in_match = [all_pieces[i][j], all_pieces[i+1][j], all_pieces[i+2][j], all_pieces[i+3][j],all_pieces[i+4][j]]
				var piece_to_make_special = all_pieces[i][j]
				
				if moved_piece in pieces_in_match:
					piece_to_make_special = moved_piece
				
				replace_with_special("star", piece_to_make_special)
				isfiveR = true
				for piece in pieces_in_match:
					if piece != piece_to_make_special:
						piece.matched = true
						piece.dim()
			# Combinación de 4
			elif i <= width - 4 and \
			all_pieces[i+1][j] != null and all_pieces[i+1][j].color == current_color and \
			all_pieces[i+2][j] != null and all_pieces[i+2][j].color == current_color and \
			all_pieces[i+3][j] != null and all_pieces[i+3][j].color == current_color:
				
				var pieces_in_match = [all_pieces[i][j], all_pieces[i+1][j], all_pieces[i+2][j], all_pieces[i+3][j]]
				var piece_to_make_special = all_pieces[i][j] # Por defecto, la primera
				
				if moved_piece in pieces_in_match:
					piece_to_make_special = moved_piece
				
				if not isfiveR:
					replace_with_special("row", piece_to_make_special)
				
				for piece in pieces_in_match:
					if piece != piece_to_make_special:
						piece.matched = true
						piece.dim()
				break
			# Combinación de 3
			elif i <= width - 3 and \
			all_pieces[i+1][j] != null and all_pieces[i+1][j].color == current_color and \
			all_pieces[i+2][j] != null and all_pieces[i+2][j].color == current_color:
				all_pieces[i][j].matched = true
				all_pieces[i][j].dim()
				all_pieces[i+1][j].matched = true
				all_pieces[i+1][j].dim()
				all_pieces[i+2][j].matched = true
				all_pieces[i+2][j].dim()
			# Combinación de 5
			if j <= height - 5 and \
			all_pieces[i][j+1] != null and all_pieces[i][j+1].color == current_color and \
			all_pieces[i][j+2] != null and all_pieces[i][j+2].color == current_color and \
			all_pieces[i][j+3] != null and all_pieces[i][j+3].color == current_color and \
			all_pieces[i][j+4] != null and all_pieces[i][j+4].color == current_color:
				
				var pieces_in_match = [all_pieces[i][j], all_pieces[i][j+1], all_pieces[i][j+2], all_pieces[i][j+3],all_pieces[i][j+4] ]
				var piece_to_make_special = all_pieces[i][j]
				
				if moved_piece in pieces_in_match:
					piece_to_make_special = moved_piece
				
				replace_with_special("star", piece_to_make_special)
				isfiveC = true
				for piece in pieces_in_match:
					if piece != piece_to_make_special:
						piece.matched = true
						piece.dim()
			# Combinación de 4
			elif j <= height - 4 and \
			all_pieces[i][j+1] != null and all_pieces[i][j+1].color == current_color and \
			all_pieces[i][j+2] != null and all_pieces[i][j+2].color == current_color and \
			all_pieces[i][j+3] != null and all_pieces[i][j+3].color == current_color:
				
				var pieces_in_match = [all_pieces[i][j], all_pieces[i][j+1], all_pieces[i][j+2], all_pieces[i][j+3]]
				var piece_to_make_special = all_pieces[i][j]
				
				if moved_piece in pieces_in_match:
					piece_to_make_special = moved_piece
				
				if not isfiveC:
					replace_with_special("column", piece_to_make_special)
				
				for piece in pieces_in_match:
					if piece != piece_to_make_special:
						piece.matched = true
						piece.dim()
						
				break
			elif j <= height - 3 and \
			all_pieces[i][j+1] != null and all_pieces[i][j+1].color == current_color and \
			all_pieces[i][j+2] != null and all_pieces[i][j+2].color == current_color:
				all_pieces[i][j].matched = true
				all_pieces[i][j].dim()
				all_pieces[i][j+1].matched = true
				all_pieces[i][j+1].dim()
				all_pieces[i][j+2].matched = true
				all_pieces[i][j+2].dim()
				
	get_parent().get_node("destroy_timer").start()

func replace_with_special(kind: String, piece_to_replace: Node2D):
	if piece_to_replace == null:
		return

	var color = piece_to_replace.color
	var grid_pos = pixel_to_grid(piece_to_replace.position.x, piece_to_replace.position.y)
	
	if grid_pos.x < 0 or grid_pos.x >= width or grid_pos.y < 0 or grid_pos.y >= height:
		print("Error: Posición de pieza especial fuera de la grilla.")
		return

	var scene_path = "res://scenes/%s_piece_%s.tscn" % [color, kind]
	var special_piece_scene = load(scene_path)
	
	if special_piece_scene == null:
		print("Error: No se pudo cargar la escena de la pieza especial: ", scene_path)
		return

	# Instanciar la pieza especial
	var special_piece = special_piece_scene.instantiate()
	add_child(special_piece)
	
	# Colocarla en la posición visual correcta
	special_piece.position = piece_to_replace.position
	special_piece.special_type = kind
	
	# Actualizar el array lógico
	all_pieces[grid_pos.x][grid_pos.y] = special_piece
	
	# Eliminar la pieza original
	piece_to_replace.queue_free()

func destroy_matched():
	var was_matched = false
	var destroyed_count = 0
	for i in width:
		for j in height:
			if all_pieces[i][j] != null and all_pieces[i][j].matched:
				if all_pieces[i][j].special_type == "star":
					for x in width:
						if all_pieces[x][j] != null:
							all_pieces[x][j].dim_2()
							all_pieces[x][j] = null
							destroyed_count += 1
					for y in height:
						if all_pieces[i][y] != null:
							all_pieces[i][y].dim_2()
							all_pieces[i][y] = null
							destroyed_count += 1
				elif all_pieces[i][j].special_type == "row":
					# destruir toda la fila j
					for x in width:
						if all_pieces[x][j] != null:
							all_pieces[x][j].dim_2()
							all_pieces[x][j] = null
							destroyed_count += 1
				elif all_pieces[i][j].special_type == "column":
					# destruir toda la columna i
					for y in height:
						if all_pieces[i][y] != null:
							all_pieces[i][y].dim_2()
							all_pieces[i][y] = null
							destroyed_count += 1
				else:
					# pieza normal
					all_pieces[i][j].dim_2()
					all_pieces[i][j] = null
					destroyed_count += 1
				was_matched = true
				
	if destroyed_count > 0:
		add_score.emit(destroyed_count * 50)
				
	move_checked = true
	if was_matched:
		reduce_counter.emit()

		get_parent().get_node("collapse_timer").start()
	else:
		swap_back()

func collapse_columns():
	for i in width:
		for j in height:
			if all_pieces[i][j] == null:
				print(i, j)
				# look above
				for k in range(j + 1, height):
					if all_pieces[i][k] != null:
						all_pieces[i][k].move(grid_to_pixel(i, j))
						all_pieces[i][j] = all_pieces[i][k]
						all_pieces[i][k] = null
						break
	get_parent().get_node("refill_timer").start()

func refill_columns():
	
	for i in width:
		for j in height:
			if all_pieces[i][j] == null:
				# random number
				var rand = randi_range(0, possible_pieces.size() - 1)
				# instance 
				var piece = possible_pieces[rand].instantiate()
				# repeat until no matches
				var max_loops = 100
				var loops = 0
				while (match_at(i, j, piece.color) and loops < max_loops):
					rand = randi_range(0, possible_pieces.size() - 1)
					loops += 1
					piece = possible_pieces[rand].instantiate()
				add_child(piece)
				piece.position = grid_to_pixel(i, j - y_offset)
				piece.move(grid_to_pixel(i, j))
				# fill array with pieces
				all_pieces[i][j] = piece
				
	check_after_refill()

func check_after_refill():
	for i in width:
		for j in height:
			if all_pieces[i][j] != null and match_at(i, j, all_pieces[i][j].color):
				find_matches()
				get_parent().get_node("destroy_timer").start()
				return
	state = MOVE
	
	move_checked = false

func _on_destroy_timer_timeout():
	print("destroy")
	destroy_matched()

func _on_collapse_timer_timeout():
	print("collapse")
	collapse_columns()

func _on_refill_timer_timeout():
	refill_columns()
	
func game_over():
	state = WAIT
	print("game over")
