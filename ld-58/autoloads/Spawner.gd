extends Node

var fish_types : Array[FishType] = [
	preload("res://resources/fish_types/zombie.tres"),
	preload("res://resources/fish_types/mummy.tres"),
	preload("res://resources/fish_types/ghost_shrimp.tres"),
	preload("res://resources/fish_types/lantern.tres"),
	preload("res://resources/fish_types/bone.tres"),
	preload("res://resources/fish_types/pumpkin.tres"),
	preload("res://resources/fish_types/frank.tres"),
	preload("res://resources/fish_types/clown.tres"),
	preload("res://resources/fish_types/werewolf.tres"),
	preload("res://resources/fish_types/alien.tres"),
	preload("res://resources/fish_types/watcher.tres"),
	preload("res://resources/fish_types/guppy.tres"),
	preload("res://resources/fish_types/upgrade0.tres"),
	preload("res://resources/fish_types/upgrade1.tres"),
	preload("res://resources/fish_types/upgrade2.tres"),
	preload("res://resources/fish_types/upgrade3.tres"),
]

var common = 50
var uncommon = 10
var rare = 2.5
var legendary = 1
var mythical = 0.1

var weights = PackedFloat32Array([
	common, common, common, common,
	uncommon, uncommon, uncommon,
	rare, rare,
	legendary, legendary,
	mythical, 40, 40, 40, 10
])

var rng = RandomNumberGenerator.new()

var fish_scene := preload("res://scenes/fishing/float_fish.tscn")

func get_fish() -> Fish:
	var new_fish := fish_scene.instantiate() as Fish
	new_fish.data = _get_fish_type()
	return new_fish


func _get_fish_type() -> FishType:
	return fish_types[rng.rand_weighted(weights)]
	# return fish_types.pick_random()
