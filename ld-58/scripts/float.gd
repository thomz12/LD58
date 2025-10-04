extends RigidBody2D

class_name Float

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var sfx_come_up := load("res://audio/fx_float_comes_up.wav")
var sfx_hit_water := load("res://audio/fx_float_hits_water.wav")
var fx_water_burst := load("res://resources/particles/water_burst.tscn")

var stuck := false
var over_ground = false
var rod : RigidBody2D
var initial_mass = 0.3

var wait_unstuck  = 0.0

var time_till_catch = 0.0
var hooked = false
var time_hooked = 0.0

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	initial_mass = mass

func _physics_process(delta: float) -> void:
	if stuck:
		#print(linear_velocity.normalized())
		if linear_velocity.length() > 0.003 and wait_unstuck < 0.0:
			stuck = false
			mass = initial_mass
			time_hooked = 0.0
			Events.float_return.emit()

			if hooked:
				var fish = Spawner.get_fish()
				fish.launch_vector = global_position.direction_to(rod.global_position)
				fish.launch_distance = global_position.distance_to(rod.global_position)
				add_child(fish)
				Events.fish_caught.emit(fish.data)

				var fx := fx_water_burst.instantiate() as CPUParticles2D
				fx.emitting = true
				fx.global_position = global_position
				rod.add_sibling(fx)

				## AUDIO STUFF
				audio_stream_player_2d.stream = sfx_come_up
				audio_stream_player_2d.play()
				
		else:
			wait_unstuck -= delta
			linear_velocity = Vector2()
			angular_velocity = 0

func _process(delta: float) -> void:
	if stuck :
		if not hooked:
			if time_till_catch > 0.0:
				time_till_catch -= delta
			else:
				hooked = true
				print("Bite!")
		else:
			scale = Vector2(2, 2)
			time_hooked += delta
			
			if time_hooked > 1.0:
				hooked = false
				time_hooked = 0.0
				time_till_catch = randf_range(2.0, 4.0)


func _on_body_entered(body):
	if body.has_meta("is_water") and body.get_meta("is_water") and not stuck:
		mass = 1000
		linear_velocity = Vector2()
		angular_velocity = 0

		wait_unstuck = 0.5
		stuck = true
		hooked = false
		time_till_catch = randf_range(3.0, 8.0)
		print("Casting!")

		## AUDIO STUFF
		audio_stream_player_2d.stream = sfx_hit_water
		audio_stream_player_2d.play()

		Events.float_cast.emit()
