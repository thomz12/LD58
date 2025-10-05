extends Sprite2D

func _process(delta: float) -> void:
	offset.x += delta * 4
	if offset.x > 14.0:
		offset.x -= 14.0
