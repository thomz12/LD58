extends RigidBody2D

@export var spring_strength: float = 800.0
@export var damping: float = 50.0

# Limit angle to between -45° and 45°
const MIN_ANGLE = deg_to_rad(-45)
const MAX_ANGLE = deg_to_rad(45)

func _physics_process(_delta: float) -> void:
	var target = get_global_mouse_position()
	var displacement = global_position - target

	# Hooke's Law: F = -k * x
	var spring_force = -displacement * spring_strength

	# Damping force: F = -d * v
	var damping_force = -linear_velocity * damping

	# Total force
	var total_force = spring_force + damping_force

	apply_force(total_force)
	
	# Lock angle
	#var angle = rotation
	#if angle < MIN_ANGLE:
		#angle = MIN_ANGLE
		#angular_velocity = 0
	#elif angle > MAX_ANGLE:
		#angle = MAX_ANGLE
		#angular_velocity = 0
	#transform = Transform2D(angle, transform.origin)
