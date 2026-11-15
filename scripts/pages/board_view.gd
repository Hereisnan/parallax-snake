extends Node2D

const CELL_SIZE := 16
const GRID_WIDTH := 32
const GRID_HEIGHT := 18
const BOARD_ORIGIN := Vector2(64, 56)

const BOARD_COLOR := Color("#101820")
const GRID_COLOR := Color("#293943")
const BORDER_COLOR := Color("#8a8b6f")
const SNAKE_COLOR := Color("#73b873")
const HEAD_COLOR := Color("#b7df79")

var snake_body: Array[Vector2i] = []

var food_cell := Vector2i(-1, -1)


func set_food_cell(new_cell: Vector2i) -> void:
	food_cell = new_cell
	queue_redraw()
	
func set_snake_body(new_body: Array[Vector2i]) -> void:
	snake_body = new_body.duplicate()
	queue_redraw()


func _draw() -> void:
	var board_size := Vector2(
		GRID_WIDTH * CELL_SIZE,
		GRID_HEIGHT * CELL_SIZE
	)
	var board_rect := Rect2(BOARD_ORIGIN, board_size)

	draw_rect(board_rect, BOARD_COLOR)

	for column in range(GRID_WIDTH + 1):
		var x := BOARD_ORIGIN.x + column * CELL_SIZE
		draw_line(
			Vector2(x, BOARD_ORIGIN.y),
			Vector2(x, BOARD_ORIGIN.y + board_size.y),
			GRID_COLOR
		)

	for row in range(GRID_HEIGHT + 1):
		var y := BOARD_ORIGIN.y + row * CELL_SIZE
		draw_line(
			Vector2(BOARD_ORIGIN.x, y),
			Vector2(BOARD_ORIGIN.x + board_size.x, y),
			GRID_COLOR
		)

	draw_rect(board_rect, BORDER_COLOR, false, 2.0)

	if food_cell != Vector2i(-1, -1):
		var food_origin := BOARD_ORIGIN + Vector2(
			food_cell.x * CELL_SIZE,
			food_cell.y * CELL_SIZE
		)
		draw_rect(
			Rect2(food_origin + Vector2.ONE, Vector2(14, 14)),
			Color("#e07a62")
		)
		
	for i in range(snake_body.size()):
		var cell := snake_body[i]
		var cell_origin := BOARD_ORIGIN + Vector2(
			cell.x * CELL_SIZE,
			cell.y * CELL_SIZE
		)
		var cell_color := HEAD_COLOR if i == 0 else SNAKE_COLOR

		draw_rect(
			Rect2(cell_origin + Vector2.ONE, Vector2(14, 14)),
			cell_color
		)
