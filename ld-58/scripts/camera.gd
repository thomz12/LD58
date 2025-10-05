extends Camera2D
class_name Camera

@export_group('Shake')
@export var shake_intensity_limit := 15.0
@export var shake_fade_speed: float = 10

var rng = RandomNumberGenerator.new()
var shake_intensity: float = 0.0

func _ready() -> void:
	Events.fish_bite.connect(func():
		apply_shake(2)
	)
	Events.fish_fake_out.connect(func():
		apply_shake(1)
	)


func _process(delta):
	if shake_intensity > 0:
		shake_intensity = lerp(shake_intensity, 0.0, shake_fade_speed * delta)
		offset = _get_random_offset()


func apply_shake(intensity : int):
	shake_intensity = intensity


func _get_random_offset() -> Vector2:
	return Vector2(
		rng.randf_range(-shake_intensity, shake_intensity),
		rng.randf_range(-shake_intensity, shake_intensity)
	)
