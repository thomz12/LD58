extends Sprite2D

var frame_time = 0.0

func _process(delta: float) -> void:
	global_rotation = -(get_parent().global_rotation / 8)
	
	frame_time += delta
	if frame_time > 0.1:
		frame_time = 0.0
		frame = (frame + 1) % hframes
	
