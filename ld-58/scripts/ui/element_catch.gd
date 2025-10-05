extends MarginContainer
class_name UIElementCatch

@onready var texture_rect: TextureRect = %TextureRect
@onready var label_name: Label = %LabelName
@onready var label_length: Label = %LabelLength
@onready var label_weight: Label = %LabelWeight

var catch : FishType

func _ready() -> void:
	texture_rect.texture = catch.sprite
	label_name.text = "%s - Score: %s" % [str(catch.identifier), catch.get_score()]
	label_length.text = "Length: %s m" % str(catch.get_length())
	label_weight.text = " - Weight: %s kg " % str(catch.get_weight())
