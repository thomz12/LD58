extends Node

var fish_types : Array[FishType] = [
	preload("res://resources/fish_types/eel.tres"),
	preload("res://resources/fish_types/ray.tres"),
	preload("res://resources/fish_types/idol.tres"),
	preload("res://resources/fish_types/tuna.tres"),
	preload("res://resources/fish_types/shark.tres"),
	preload("res://resources/fish_types/clown.tres"),
	preload("res://resources/fish_types/angler.tres"),
	preload("res://resources/fish_types/shrimp.tres"),
	preload("res://resources/fish_types/piranha.tres"),
	preload("res://resources/fish_types/regular.tres"),
	preload("res://resources/fish_types/goldfish.tres"),
	preload("res://resources/fish_types/carvanha.tres"),
]

var fish_scene := preload("res://scenes/fishing/float_fish.tscn")


func get_fish() -> Fish:
	var new_fish := fish_scene.instantiate() as Fish
	new_fish.data = _get_fish_type()
	return new_fish


func _get_fish_type() -> FishType:
	return fish_types.pick_random()
