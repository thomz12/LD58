extends RigidBody2D

class_name Float

var stuck := false
var over_ground = false
var cast = false

var initial_mass = 0.3

var wait_unstuck  = 0.0

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	initial_mass = mass

func _physics_process(delta: float) -> void:
	if stuck:
		print(linear_velocity.length())
		if linear_velocity.length() > 0.003 and wait_unstuck < 0.0:
			stuck = false
			mass = initial_mass
			Events.float_return.emit()
			
			var fish = load("res://scenes/fishing/float_fish.tscn").instantiate() as Fish
			fish.data = load("res://resources/fish_types/angler.tres")
			add_child(fish)
			Events.fish_caught.emit(fish.data)
			
			# TODO doesn't work:
			apply_impulse.call_deferred(Vector2(-100, -300))
		else:
			wait_unstuck -= delta
			linear_velocity = Vector2()
			angular_velocity = 0
			
func _process(_delta: float) -> void:
	if cast and over_ground:
		cast = false
		
	
func _on_body_entered(body):
	if body.has_meta("is_water") and body.get_meta("is_water") and not cast:
		mass = 1000
		linear_velocity = Vector2()
		angular_velocity = 0
		
		wait_unstuck = 0.5
		stuck = true
		cast = true
		print("Casting!")
		Events.float_cast.emit()
