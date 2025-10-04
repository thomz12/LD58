extends RigidBody2D
class_name Fish

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var data : FishType


func _ready() -> void:
	
	apply_impulse.call_deferred(Vector2(-150, -400))
	apply_torque_impulse.call_deferred(100)
	
	assert(data, 'Fish without an identity. No data was set.')
	sprite_2d.texture = data.sprite
