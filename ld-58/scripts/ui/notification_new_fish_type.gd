extends MarginContainer
class_name NotificationNewFishType

@onready var label_title: Label = %LabelTitle
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var texture_rect: TextureRect = %TextureRect
@onready var label_name: Label = %LabelName
@onready var label_rarity: RichTextLabel = %LabelRarity

var data: FishType

func _ready() -> void:
	if data.rarity == FishType.RARITY.UPGRADE:
		_set_upgrade_data()
	else:
		_set_fish_data()

	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 0, 1.0).set_delay(5.0)
	tween.tween_callback(func(): queue_free())

	audio_stream_player.play()


func _set_fish_data() -> void:
	label_name.text = data.identifier
	var color := ""
	match data.rarity:
		0:color = "Green"
		1:color = "Blue"
		2:color = "Red"
		3: color = "Purple"
		4: color = "Orange"

	label_rarity.text = "[color=%s]%s" % [color, FishType.RARITY.find_key(data.rarity)]
	texture_rect.texture = data.sprite


func _set_upgrade_data() -> void:
	label_title.text = "New upgrade unlocked"
	label_name.text = data.identifier
	texture_rect.texture = data.sprite
	label_rarity.text = data.upgrade_description
