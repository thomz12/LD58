extends Sprite2D


func _on_area_2d_mouse_entered() -> void:
	Events.ui_dislay_fish_stat.emit(name, self)


func _on_area_2d_mouse_exited() -> void:
	Events.ui_stop_display_fish_stat.emit()
