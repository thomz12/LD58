extends Area2D

func _ready() -> void:
	connect("body_entered", 
		func(body: Node2D):
			if body is Float:
				body = body as Float
				body.over_ground = true
	)
	
	connect("body_exited", 
		func(body: Node2D):
			if body is Float:
				body = body as Float
				body.over_ground = false
	)
