extends Node2D

@onready var pause_menu: Control = %PauseMenu
@onready var label_time: Label = %LabelTime

@onready var start_menu: Control = %StartMenu
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var transition_color_rect: ColorRect = %TransitionColorRect

@onready var hud: HUD = $Main/CanvasLayer/HUD


var is_loading := false

func _ready() -> void:
	get_tree().paused = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		pause_menu.visible = get_tree().paused
		var time_elapsed = hud.game_time

		var minutes = time_elapsed / 60
		var seconds = fmod(time_elapsed, 60)

		label_time.text = "%02d:%02d" % [minutes, seconds]


func _on_start_menu_game_start() -> void:
	if is_loading: return
	is_loading = true
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
