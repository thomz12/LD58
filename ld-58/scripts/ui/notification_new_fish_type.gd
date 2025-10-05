extends MarginContainer
class_name NotificationNewFishType

@onready var label_title: Label = %LabelTitle
@onready var texture_rect: TextureRect = %TextureRect
@onready var label_name: Label = %LabelName
@onready var label_rarity: Label = %LabelRarity

var fish_type: FishType

func _ready() -> void:
	label_name.text = fish_type.identifier
	label_rarity.text = FishType.RARITY.find_key(fish_type.rarity)
	texture_rect.texture = fish_type.sprite

	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 0, 1.0).set_delay(5.0)
