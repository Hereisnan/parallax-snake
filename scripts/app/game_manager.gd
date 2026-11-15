extends Control

const GAME_PAGE_SCENE = preload("res://scenes/pages/game_page.tscn")

@onready var page_root: Control = $PageRoot
@onready var start_button: Button = $PageRoot/StartPage/PlayButton


func _ready() -> void:
	start_button.pressed.connect(_on_start_pressed)


func _on_start_pressed() -> void:
	var current_page = page_root.get_child(0)
	page_root.remove_child(current_page)
	current_page.queue_free()

	var game_page = GAME_PAGE_SCENE.instantiate()
	page_root.add_child(game_page)

	if game_page is Control:
		game_page.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
