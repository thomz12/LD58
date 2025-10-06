extends Node

var fish_scene := load("res://scenes/fishing/float_fish.tscn")

var catch_history : Array[FishType] = []

var has_all_but_guppy = false

func _ready() -> void:
	Events.fish_caught.connect(_on_fish_caught)


func get_catch_count(fish_type: FishType) -> int:
	var count := 0
	for catch in catch_history:
		if catch.identifier == fish_type.identifier:
			count += 1

	return count


func get_catch_count_by_identifier(fish_type: String) -> int:
	var count := 0
	for catch in catch_history:
		if catch.identifier == fish_type:
			count += 1

	return count


func is_new_fish_type(fish_type: FishType) -> bool:
	var is_new := true

	for catch in catch_history:
		if catch.identifier == fish_type.identifier:
			is_new = false

	return is_new


func get_unique_count() -> int:
	var seen : Array[String] = []

	for catch in catch_history:
		if not seen.has(catch.identifier) and catch.rarity != FishType.RARITY.UPGRADE:
			seen.append(catch.identifier)

	return seen.size()


func _on_fish_caught(fish: Fish) -> void:
	if is_new_fish_type(fish.data) or fish.data.rarity == FishType.RARITY.UPGRADE:
		Events.notification_new_fish_type.emit(fish.data)

	catch_history.append(fish.data)

	var count = get_unique_count()

	## Has every type been caught?
	if 12 == count:
		print('caught every fish. Game Over!')
		Events.game_won.emit()

	if 11 == count:
		print("One more!!")
		has_all_but_guppy = true
