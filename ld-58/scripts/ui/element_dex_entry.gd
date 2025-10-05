extends MarginContainer
class_name UIElementDexEntry

@onready var texture_rect: TextureRect = %TextureRect
@onready var label_name: RichTextLabel = %LabelName
@onready var label_caught: Label = %LabelCaught


func update_entry(fish_type: FishType) -> void:
	texture_rect.texture = fish_type.sprite

	if Progress.get_catch_count(fish_type) == 0:
		label_name.text = "[color=%s]?????????" % fish_type.get_rarity_color(fish_type.rarity)
		label_caught.text = "Not caught yet"
		texture_rect.material.set_shader_parameter('black_out', true)
	else:
		label_name.text = "[color=%s]%s" % [fish_type.get_rarity_color(fish_type.rarity), fish_type.identifier]
		label_caught.text = "Caught: %s" %  str(Progress.get_catch_count(fish_type))
		texture_rect.material.set_shader_parameter('black_out', false)
