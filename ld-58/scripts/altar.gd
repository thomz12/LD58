extends Node2D


func _ready() -> void:
	Events.notification_new_fish_type.connect(_on_new_fish_type_caught)


func _on_new_fish_type_caught(fish_type: FishType) -> void:
	if fish_type.rarity == FishType.RARITY.UPGRADE: return

	var node := find_child(fish_type.identifier) as Sprite2D

	var tween := create_tween()
	tween.tween_property(node, 'modulate', Color.WHITE, .2)

	var altar_tween := create_tween()
	altar_tween.tween_property($SpriteAltar, 'modulate', fish_type.get_rarity_color(fish_type.rarity), .2)
	altar_tween.chain().tween_property($SpriteAltar, 'modulate', Color.WHITE, .2)
