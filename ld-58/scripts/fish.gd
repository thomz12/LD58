extends Node2D
class_name Fish

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var data : FishType


func _ready() -> void:
	assert(data, 'Fish without an identity. No data was set.')

	sprite_2d.texture = data.sprite

	## TODO: Debug so remove
	Events.fish_caught.emit(self)
