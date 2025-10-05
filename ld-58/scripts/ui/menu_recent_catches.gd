extends MarginContainer
class_name MenuRecentCatches

@onready var catches_container: VBoxContainer = %CatchesContainer

var catch_ui_element := load("res://scenes/ui/catches/catch.tscn")
var catches: Array[FishType] = []

func _ready() -> void:
	catches = Progress.catch_history

	for catch in catches:
		var catch_container = catch_ui_element.instantiate() as UIElementCatch
		catch_container.catch = catch
		catches_container.add_child(catch_container)
