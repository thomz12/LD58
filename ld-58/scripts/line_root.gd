extends Node2D

@export
var segments = 1;

var line_segment := preload("res://scenes/fishing/line_segment.tscn")
var float_scene := preload("res://scenes/fishing/float.tscn")

func _ready() -> void:
	await get_tree().process_frame
	
	var next_segment := self as Node2D
	var parent_body := get_parent() as RigidBody2D
	
	for i in range(segments):		
		var segment := line_segment.instantiate() as RigidBody2D
		next_segment.add_child(segment)
		segment.position = Vector2()
	
		var joint := PinJoint2D.new()
		next_segment.add_child(joint)
		joint.node_a = parent_body.get_path()
		joint.node_b = segment.get_path()
		joint.softness = 4
		
		parent_body = segment
		next_segment = segment.find_child("Anchor")
		
	var float_inst = float_scene.instantiate() as RigidBody2D
	next_segment.add_child(float_inst)
	
	var float_joint := PinJoint2D.new()
	next_segment.add_child(float_joint)

	float_joint.node_a = float_inst.get_path()
	float_joint.node_b = parent_body.get_path()
	
	Events.add_camera_target.emit(float_inst)
	
