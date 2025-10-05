extends Node2D

@onready var pause_menu: Control = %PauseMenu
@onready var start_menu: Control = %StartMenu
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var transition_color_rect: ColorRect = %TransitionColorRect

func _ready() -> void:
	get_tree().paused = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		pause_menu.visible = get_tree().paused


func _on_button_continue_pressed() -> void:
	get_tree().paused = false
	pause_menu.hide()


func _on_start_menu_game_start() -> void:
	await trans(0.0, 1.0, 90, true)
	start_menu.queue_free()
	await trans(1.0, 0.0, 270, true)
	get_tree().paused = false


func trans(origin := 0.0, target := 1.0, angle := 0.0, wait := false) -> void:
	transition_color_rect.material['shader_parameter/angle'] = angle
	var tween = create_tween()
	tween.tween_property(
		transition_color_rect.material,
		"shader_parameter/progress",
		target,
		1.5
	).from(origin).set_trans(Tween.TRANS_SINE)

	if wait: await tween.finished
