extends RigidBody2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _physics_process(_delta: float) -> void:
	print("velocity: " + str(linear_velocity.length()))

func _on_body_entered(body):
	if body.has_meta("is_water") and body.get_meta("is_water"):
		linear_velocity = Vector2()
		angular_velocity = 0
		mass = 1000
		
