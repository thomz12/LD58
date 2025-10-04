extends Node2D

@export var data : FishType

func _ready() -> void:
	print(data.identifier)
