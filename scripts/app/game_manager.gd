extends Control

const START_PAGE_SCENE = preload("res://scenes/pages/start_page.tscn")
const GAME_PAGE_SCENE = preload("res://scenes/pages/game_page.tscn")
const GAME_OVER_PAGE_SCENE = preload("res://scenes/pages/game_over_page.tscn")

@onready var page_root: Control = $PageRoot


func _ready() -> void:
	var start_page = page_root.get_child(0)
	start_page.get_node("PlayButton").pressed.connect(_start_game)


func _start_game() -> void:
	var game_page = _replace_page(GAME_PAGE_SCENE)
	game_page.game_over.connect(_show_game_over)


func _show_game_over(final_score: int) -> void:
	var game_over_page = _replace_page(GAME_OVER_PAGE_SCENE)
	game_over_page.set_final_score(final_score)
	game_over_page.retry_pressed.connect(_start_game)
	game_over_page.main_menu_pressed.connect(_return_to_main_menu)


func _return_to_main_menu() -> void:
	var start_page = _replace_page(START_PAGE_SCENE)
	start_page.get_node("PlayButton").pressed.connect(_start_game)


func _replace_page(scene: PackedScene):
	var old_pages := page_root.get_children()

	for old_page in old_pages:
		page_root.remove_child(old_page)
		old_page.queue_free()

	var new_page = scene.instantiate()
	page_root.add_child(new_page)

	if new_page is Control:
		new_page.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	return new_page
