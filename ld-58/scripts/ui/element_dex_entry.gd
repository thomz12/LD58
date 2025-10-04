extends MarginContainer
class_name UIElementDexEntry

@onready var texture_rect: TextureRect = %TextureRect
@onready var label_name: Label = %LabelName
@onready var label_caught: Label = %LabelCaught


func update_entry(fish_type: FishType) -> void:
	texture_rect.texture = fish_type.sprite

	if Progress.get_catch_count(fish_type) == 0:
		label_name.text = "?????????"
		label_caught.text = "Not caught yet"
		texture_rect.material.set_shader_parameter('black_out', true)
	else:
		label_name.text = fish_type.identifier
		label_caught.text = "Caught: %s" % str(Progress.get_catch_count(fish_type))
		texture_rect.material.set_shader_parameter('black_out', false)
