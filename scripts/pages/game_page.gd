extends Control

signal game_over(final_score: int)

@onready var board_view: Node2D = $BoardView
@onready var snake = $Snake
@onready var score_label: Label = $ScoreLabel

var score := 0
var food_cell := Vector2i(-1, -1)


func _ready() -> void:
	score_label.text = "Score: 0"

	snake.body_changed.connect(_on_snake_body_changed)
	snake.died.connect(_on_snake_died)

	board_view.set_snake_body(snake.body)

	food_cell = _spawn_food(snake.body)
	board_view.set_food_cell(food_cell)


func _on_snake_body_changed(new_body: Array[Vector2i]) -> void:
	board_view.set_snake_body(new_body)

	if new_body[0] == food_cell:
		score += 1
		score_label.text = "Score: %d" % score

		snake.grow()
		food_cell = _spawn_food(new_body)
		board_view.set_food_cell(food_cell)


func _on_snake_died() -> void:
	game_over.emit(score)


func _spawn_food(occupied_cells: Array[Vector2i]) -> Vector2i:
	var free_cells: Array[Vector2i] = []

	for y in range(18):
		for x in range(32):
			var cell := Vector2i(x, y)
			if not occupied_cells.has(cell):
				free_cells.append(cell)

	if free_cells.is_empty():
		return Vector2i(-1, -1)

	return free_cells.pick_random()
