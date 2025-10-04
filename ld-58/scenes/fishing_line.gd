extends Line2D

@export
var line_root : Node2D

func _process(_delta: float) -> void:
	
	if line_root == null:
		print("line_root not set!")
	
	var line_points: Array[Vector2] = []
	line_points.append(line_root.position)
	
	var current_node := line_root
	while current_node != null:
		line_points.append(to_local(current_node.global_position))
		
		var anchor := current_node.get_child(0).get_child(1)
		if anchor.get_child_count() > 0:
			var next_node := anchor
			
			# Only follow if it's a Node2D (so it has global_position)
			if next_node is Node2D:
				current_node = next_node
			else:
				break
		else:
			break
	
	points = line_points
