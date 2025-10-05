extends Control

signal game_start

func _on_button_start_pressed() -> void:
	game_start.emit()
