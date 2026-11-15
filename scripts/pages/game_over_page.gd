extends Control

signal retry_pressed
signal main_menu_pressed

@onready var final_score_label: Label = $CenterContainer/VBoxContainer/FinalScoreLabel
@onready var retry_button: Button = $CenterContainer/VBoxContainer/RetryButton
@onready var main_menu_button: Button = $CenterContainer/VBoxContainer/MainMenuButton


func _ready() -> void:
	retry_button.pressed.connect(_on_retry_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)


func set_final_score(value: int) -> void:
	final_score_label.text = "Final Score: %d" % value


func _on_retry_pressed() -> void:
	retry_pressed.emit()


func _on_main_menu_pressed() -> void:
	main_menu_pressed.emit()
