extends Sprite2D

@onready var rich_text_label: RichTextLabel = $RichTextLabel

func _on_area_2d_mouse_entered() -> void:
	rich_text_label.show()
	rich_text_label.text = "[bgcolor=BLACK] caught: %s" % Progress.get_catch_count_by_identifier(name)


func _on_area_2d_mouse_exited() -> void:
	rich_text_label.hide()
