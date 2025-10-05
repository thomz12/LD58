extends Control
class_name HUD

var notification_fish_scene := load("res://scenes/ui/notifications/notification_new_fish_type.tscn")

func _ready() -> void:
	Events.notification_new_fish_type.connect(_on_new_fish_type_caught)


func _on_new_fish_type_caught(data: FishType) -> void:
	var notification = notification_fish_scene.instantiate() as NotificationNewFishType
	notification.data = data
	add_child(notification)
