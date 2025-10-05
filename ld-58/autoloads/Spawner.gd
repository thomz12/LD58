extends Node

var fish_types : Array[FishType] = [
	preload("res://resources/fish_types/alien.tres"),
	preload("res://resources/fish_types/bone.tres"),
	preload("res://resources/fish_types/frank.tres"),
	preload("res://resources/fish_types/ghost_shrimp.tres"),
	preload("res://resources/fish_types/guppy.tres"),
	preload("res://resources/fish_types/clown.tres"),
	preload("res://resources/fish_types/lantern.tres"),
	preload("res://resources/fish_types/mummy.tres"),
	preload("res://resources/fish_types/pumpkin.tres"),
	preload("res://resources/fish_types/watcher.tres"),
	preload("res://resources/fish_types/werewolf.tres"),
	preload("res://resources/fish_types/zombie.tres"),
]

var fish_scene := preload("res://scenes/fishing/float_fish.tscn")


func get_fish() -> Fish:
	var new_fish := fish_scene.instantiate() as Fish
	new_fish.data = _get_fish_type()
	return new_fish


func _get_fish_type() -> FishType:
	return fish_types.pick_random()
