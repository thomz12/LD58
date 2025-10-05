extends Node2D

@onready var pause_menu: Control = %PauseMenu
@onready var canvas_layer: CanvasLayer = $CanvasLayer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		pause_menu.visible = get_tree().paused


func _on_button_continue_pressed() -> void:
	get_tree().paused = false
	pause_menu.hide()
