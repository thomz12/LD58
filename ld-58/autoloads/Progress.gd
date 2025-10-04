extends Node

var fish_types := [
	preload("res://resources/shark.tres"),
	preload("res://resources/shrimp.tres"),
	preload("res://resources/goldfish.tres")
]
var fish_scene := load("res://scenes/fish.tscn")

var catch_history : Array[Fish] = []


func _ready() -> void:
	# TODO: turn back on
	#Events.fish_caught.connect(_on_fish_caught)

	## TODO: test data remove
	for i in 10:
		var fish := fish_scene.instantiate() as Fish
		fish.data = load("res://resources/shark.tres")
		add_child(fish)
		catch_history.append(fish)


func get_catch_count(fish_type: FishType) -> int:
	var count := 0
	for catch in catch_history:
		if catch.data.identifier == fish_type.identifier:
			count += 1

	return count


func _on_fish_caught(fish: Fish) -> void:
	catch_history.append(fish)
