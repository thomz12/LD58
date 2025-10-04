extends MarginContainer
class_name MenuDex

@onready var dex_entry: MarginContainer = %DexEntry
@onready var label_index: Label = %LabelIndex
@onready var button_next: Button = %ButtonNext
@onready var button_previous: Button = %ButtonPrevious


var array_index := 0


func _ready() -> void:
	_update_entry()


func _update_entry() -> void:
	dex_entry.update_entry(Spawner.fish_types[array_index])
	label_index.text = "%s/%s" % [str(array_index + 1), Spawner.fish_types.size()]


func _on_button_previous_pressed() -> void:
	if array_index > 0:
		array_index -= 1

		if array_index == 0:
			button_previous.hide()

	button_next.show()
	_update_entry()


func _on_button_next_pressed() -> void:
	if array_index < Spawner.fish_types.size() - 1:
		array_index += 1

		if array_index == Spawner.fish_types.size() - 1:
			button_next.hide()

	button_previous.show()
	_update_entry()
