extends MarginContainer
class_name MenuDex

@onready var dex_entry: MarginContainer = %DexEntry
@onready var label_index: Label = %LabelIndex
@onready var button_next: Button = %ButtonNext
@onready var button_previous: Button = %ButtonPrevious


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
var array_index := 0


func _ready() -> void:
	_update_entry()


func _update_entry() -> void:
	dex_entry.update_entry(fish_types[array_index])
	label_index.text = "%s/%s" % [str(array_index + 1), fish_types.size()]


func _on_button_previous_pressed() -> void:
	if array_index > 0:
		array_index -= 1

		if array_index == 0:
			button_previous.hide()

	button_next.show()
	_update_entry()


func _on_button_next_pressed() -> void:
	if array_index < fish_types.size() - 1:
		array_index += 1

		if array_index == fish_types.size() - 1:
			button_next.hide()

	button_previous.show()
	_update_entry()
