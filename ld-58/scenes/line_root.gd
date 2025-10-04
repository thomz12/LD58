extends Node2D

@export
var segments = 1;

var line_segment = preload("res://scenes/line_segment.tscn")

func _ready() -> void:
	for i in range(segments):
		var segment = line_segment.instantiate();
		get_parent().add_child.call_deferred(segment);
		print(get_parent().name)
		# segment.BodyA = get_parent()
	
