extends Sprite2D

func _process(_delta: float) -> void:
	global_rotation = -(get_parent().global_rotation / 8)
