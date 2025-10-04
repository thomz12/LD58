extends RigidBody2D

class_name Float

var stuck := false
var over_ground = false
var cast = false

var initial_mass = 0.3

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	initial_mass = mass

func _physics_process(_delta: float) -> void:
	if stuck:
		if linear_velocity.length() > 0.15:
			stuck = false
			mass = initial_mass
			Events.float_return.emit()
			
			var fish = load("res://scenes/fishing/float_fish.tscn").instantiate() as Fish
			fish.data = load("res://resources/fish_types/angler.tres")
			add_child(fish)
			Events.fish_caught.emit(fish.data)
			
func _process(delta: float) -> void:
	if cast and over_ground:
		cast = false
		
	
func _on_body_entered(body):
	if body.has_meta("is_water") and body.get_meta("is_water") and not cast:
		linear_velocity = Vector2()
		angular_velocity = 0
		mass = 1000
		stuck = true
		cast = true
		print("Casting!")
		Events.float_cast.emit()
