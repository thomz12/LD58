extends MarginContainer
class_name NotificationGameWon

@onready var label_time: Label = %LabelTime

var game_time := 0.0

func _ready() -> void:
	label_time.text = "It took you %s" % format_time(game_time)


func format_time(time_elapsed: float) -> String:
	var minutes = time_elapsed / 60
	var seconds = fmod(time_elapsed, 60)

	return "%02d:%02d" % [minutes, seconds]
