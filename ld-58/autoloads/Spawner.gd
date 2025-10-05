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

var common_start = 50.0
var uncommon_start = 10.0
var rare_start = 2.5
var legendary_start = 0.1
var mythical_start = 0.01
var normal_upgrade_start = 30.0
var special_upgrade_start = 1.0

var common_end = 30.0
var uncommon_end = 15.0
var rare_end = 5.0
var legendary_end = 2.5
var mythical_end = 1.0
var normal_upgrade_end = 20.0
var special_upgrade_end = 1.0

var common = common_start
var uncommon = uncommon_start
var rare = rare_start
var legendary = legendary_start
var mythical = mythical_start
var normal_upgrade = normal_upgrade_start
var special_upgrade = special_upgrade_start

var level = 0

var rng = RandomNumberGenerator.new()

var fish_scene := preload("res://scenes/fishing/float_fish.tscn")

func get_fish(only_fish = false) -> Fish:
	var new_fish := fish_scene.instantiate() as Fish
	new_fish.data = _get_fish_type(only_fish)
	return new_fish

func increase_odds():
	level += 1
	var t = 1.0 - exp(-level * 0.05)
	common = lerp(common_start, common_end, t)
	uncommon = lerp(uncommon_start, uncommon_end, t)
	rare = lerp(rare_start, rare_end, t)
	legendary = lerp(legendary_start, legendary_end, t)
	mythical = lerp(mythical_start, mythical_end, t)
	normal_upgrade = lerp(normal_upgrade_start, normal_upgrade_end, t)
	special_upgrade = lerp(special_upgrade_start, special_upgrade_end, t)
	
	print("Level: ", level, " odds:")
	print("common: ", common);
	print("uncommon: ", uncommon);
	print("rare: ", rare);
	print("legendary: ", legendary);
	print("mythical: ", mythical);
	print("normal_upgrade: ", normal_upgrade);
	print("special_upgrade: ", special_upgrade);
	

func _get_fish_type(only_fish = false) -> FishType:
	
	var weights = [common, uncommon, rare, legendary, mythical, 0 if only_fish else normal_upgrade, 0 if only_fish else special_upgrade]
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
