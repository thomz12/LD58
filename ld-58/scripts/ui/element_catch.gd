extends MarginContainer
class_name UIElementCatch

@onready var texture_rect: TextureRect = %TextureRect
@onready var label_name: Label = %LabelName
@onready var label_length: Label = %LabelLength
@onready var label_weight: Label = %LabelWeight

var catch : Fish

func _ready() -> void:
	texture_rect.texture = catch.data.sprite
	label_name.text = "%s - Score: %s" % [str(catch.data.identifier), catch.data.get_score()]
	label_length.text = "Length: %s m" % str(catch.data.get_length())
	label_weight.text = " - Weight: %s kg " % str(catch.data.get_weight())
