extends Control
class_name HUD

@onready var label_start_info: RichTextLabel = %LabelStartInfo

var notification_won_scene := load("res://scenes/ui/notifications/notification_game_won.tscn")
var notification_fish_scene := load("res://scenes/ui/notifications/notification_new_fish_type.tscn")

var game_time := 0.0 ## This should not be here
var game_over := false

func _ready() -> void:
	Events.notification_new_fish_type.connect(_on_new_fish_type_caught)
	Events.game_won.connect(_on_game_won)

func _process(delta: float) -> void:
	if not game_over: game_time += delta


func _on_new_fish_type_caught(data: FishType) -> void:
	if label_start_info.visible and data.rarity != FishType.RARITY.UPGRADE:
		## Hide the label when the first fish is caught
		label_start_info.text = "[wave amp=30.0 freq=-2.0 connected=1][pulse freq=1.0]...%s...[/pulse][/wave]" % data.flavour_text
		label_start_info.modulate = Color.WHITE
		var tween := create_tween()
		tween.tween_property(label_start_info, 'modulate:a', 0, 1.0).set_delay(6.0)

	var new_notification = notification_fish_scene.instantiate() as NotificationNewFishType
	new_notification.data = data
	add_child(new_notification)


func _on_game_won() -> void:
	game_over = true
	await get_tree().create_timer(5.0).timeout
	var new_notification = notification_won_scene.instantiate() as NotificationGameWon
	new_notification.game_time = game_time
	add_child(new_notification)
