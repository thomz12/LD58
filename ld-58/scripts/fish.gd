extends RigidBody2D
class_name Fish

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var data : FishType

var launch_vector := Vector2.ZERO
var launch_distance := 0.0
var launch_force := 7.5

func _ready() -> void:
	apply_impulse.call_deferred(launch_vector * (launch_force * launch_distance))
	apply_torque_impulse.call_deferred(100)

	assert(data, 'Fish without an identity. No data was set.')
	sprite_2d.texture = data.sprite

	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 0, 1.0).set_delay(3.0)
	tween.tween_callback(func():
		queue_free()
	)
