extends Node

signal body_changed(body: Array[Vector2i])
signal died

const GRID_WIDTH := 32
const GRID_HEIGHT := 18
const STEP_INTERVAL := 0.18

var body: Array[Vector2i] = [
	Vector2i(15, 9),
	Vector2i(14, 9),
	Vector2i(13, 9)
]

var direction := Vector2i.RIGHT
var elapsed := 0.0
var is_alive := true

var grow_pending := false


func grow() -> void:
	grow_pending = true
	

func _process(delta: float) -> void:
	if not is_alive:
		return

	elapsed += delta
	if elapsed >= STEP_INTERVAL:
		elapsed -= STEP_INTERVAL
		_move_one_cell()


func _unhandled_key_input(event: InputEvent) -> void:
	if not event is InputEventKey or not event.pressed or event.echo:
		return

	match event.keycode:
		KEY_UP, KEY_W:
			_change_direction(Vector2i.UP)
		KEY_DOWN, KEY_S:
			_change_direction(Vector2i.DOWN)
		KEY_LEFT, KEY_A:
			_change_direction(Vector2i.LEFT)
		KEY_RIGHT, KEY_D:
			_change_direction(Vector2i.RIGHT)


func _change_direction(new_direction: Vector2i) -> void:
	if new_direction != -direction:
		direction = new_direction


func _move_one_cell() -> void:
	var next_head := body[0] + direction

	next_head.x = posmod(next_head.x, GRID_WIDTH)
	next_head.y = posmod(next_head.y, GRID_HEIGHT)

	var collision_limit := body.size()
	if not grow_pending:
		collision_limit -= 1

	for i in range(collision_limit):
		if body[i] == next_head:
			_die()
			return

	body.push_front(next_head)

	if grow_pending:
		grow_pending = false
	else:
		body.pop_back()

	body_changed.emit(body)


func _die() -> void:
	is_alive = false
	died.emit()
