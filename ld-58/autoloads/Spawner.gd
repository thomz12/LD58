extends Node

var common_fish : Array[FishType] = [
	preload("res://resources/fish_types/zombie.tres"),
	preload("res://resources/fish_types/mummy.tres"),
	preload("res://resources/fish_types/ghost_shrimp.tres"),
	preload("res://resources/fish_types/lantern.tres"),
]

var uncommon_fish : Array[FishType] = [
	preload("res://resources/fish_types/bone.tres"),
	preload("res://resources/fish_types/pumpkin.tres"),
	preload("res://resources/fish_types/frank.tres"),
]

var rare_fish : Array[FishType] = [
	preload("res://resources/fish_types/clown.tres"),
	preload("res://resources/fish_types/werewolf.tres"),
]

var legendary_fish : Array[FishType] = [
	preload("res://resources/fish_types/alien.tres"),
	preload("res://resources/fish_types/watcher.tres"),
]

var mythical_fish : Array[FishType] = [
	preload("res://resources/fish_types/guppy.tres"),
]

var normal_upgrades : Array[FishType] = [
	preload("res://resources/fish_types/upgrade0.tres"),
	preload("res://resources/fish_types/upgrade1.tres"),
	preload("res://resources/fish_types/upgrade2.tres"),
]

var special_upgrades : Array[FishType] = [
	preload("res://resources/fish_types/upgrade3.tres"),
]

var common = 50
var uncommon = 10
var rare = 2.5
var legendary = 1
var mythical = 0.1
var normal_upgrade = 40
var special_upgrade = 10

var rng = RandomNumberGenerator.new()

var fish_scene := preload("res://scenes/fishing/float_fish.tscn")

func get_fish() -> Fish:
	var new_fish := fish_scene.instantiate() as Fish
	new_fish.data = _get_fish_type()
	return new_fish

func _get_fish_type() -> FishType:
	
	var weights = [common, uncommon, rare, legendary, mythical, normal_upgrade, special_upgrade]
	var type = rng.rand_weighted(weights)
	
	match type:
		0:
			return common_fish.pick_random()
		1:
			return uncommon_fish.pick_random()
		2:
			return rare_fish.pick_random()
		3:
			return legendary_fish.pick_random()
		4:
			return mythical_fish.pick_random()
		5:
			return normal_upgrades.pick_random()
		6:
			return special_upgrades.pick_random()
		
	return common_fish.pick_random()
