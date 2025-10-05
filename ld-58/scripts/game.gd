extends Node2D

@onready var pause_menu: Control = %PauseMenu


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		pause_menu.visible = get_tree().paused
