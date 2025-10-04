extends Node

var fish_scene := load("res://scenes/fish.tscn")

var catch_history : Array[Fish] = []


func _ready() -> void:
	Events.fish_caught.connect(_on_fish_caught)

	## TODO: test data remove
	for i in 10:
		var fish := fish_scene.instantiate() as Fish
		fish.data = load("res://resources/shark.tres")
		add_child(fish)
		catch_history.append(fish)


func _on_fish_caught(fish: Fish) -> void:
	catch_history.append(fish)
