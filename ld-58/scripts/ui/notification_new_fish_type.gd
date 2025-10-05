extends MarginContainer
class_name NotificationNewFishType

@onready var label_title: Label = %LabelTitle
@onready var texture_rect: TextureRect = %TextureRect
@onready var label_name: Label = %LabelName
@onready var label_rarity: RichTextLabel = %LabelRarity

var fish_type: FishType

func _ready() -> void:
	label_name.text = fish_type.identifier
	var color := ""
	match fish_type.rarity:
		0:color = "Green"
		1:color = "Blue"
		2:color = "Red"
		3: color = "Purple"
		4: color = "Orange"

	label_rarity.text = "[color=%s]%s" % [color, FishType.RARITY.find_key(fish_type.rarity)]
	texture_rect.texture = fish_type.sprite

	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 0, 1.0).set_delay(5.0)
	tween.tween_callback(func(): queue_free())
