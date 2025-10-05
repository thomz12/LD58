extends Node

var fish_scene := load("res://scenes/fishing/float_fish.tscn")

var catch_history : Array[FishType] = []


func _ready() -> void:
	Events.fish_caught.connect(_on_fish_caught)

	## TODO: test data remove
	#for i in 10:
		#var fish := fish_scene.instantiate() as Fish
		#fish.data = load("res://resources/fish_types/zombie.tres")
		#add_child(fish)
		#catch_history.append(fish)


func get_catch_count(fish_type: FishType) -> int:
	var count := 0
	for catch in catch_history:
		if catch.identifier == fish_type.identifier:
			count += 1

	return count


func is_new_fish_type(fish_type: FishType) -> bool:
	var is_new := true

	for catch in catch_history:
		if catch.identifier == fish_type.identifier:
			is_new = false

	return is_new


func _on_fish_caught(fish: Fish) -> void:
	if is_new_fish_type(fish.data):
		Events.notification_new_fish_type.emit(fish.data)

	catch_history.append(fish.data)
