extends RigidBody2D
class_name Rod

@export var spring_strength: float = 800.0
@export var damping: float = 50.0

func _ready() -> void:
	Events.rod_spawned.emit()

	#Events.rod_spawned.connect(
		#func(rod: Rod) : targets.append(rod)
	#)

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
