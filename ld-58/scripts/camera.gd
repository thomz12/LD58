extends Camera2D


@export
var targets: Array[Node2D];

func _ready() -> void:
	position_smoothing_enabled = true
	position_smoothing_speed = 3
	
	Events.add_camera_target.connect(
		func(target: Node2D):
			targets.append(target)
	)

func _process(_delta: float) -> void:
	
	var average_position := Vector2()
	if targets.size() > 0:
		for target in targets:
			average_position += target.global_position
		average_position /= targets.size()
	else:
		print("No targets in array.")
		
	position = Vector2(average_position.x, position.y)
	
