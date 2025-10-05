extends RigidBody2D

class_name Float

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var sfx_come_up := load("res://audio/fx_float_comes_up.wav")
var sfx_no_catch := load("res://audio/fx_float_something_water_thing.wav")
var sfx_fish_bite := load("res://audio/fx_fish_bite.wav")
var sfx_hit_water := load("res://audio/fx_float_hits_water.wav")
var sfx_fake_out := load("res://audio/sfx_fish_fake_out.wav")
var fx_water_burst := load("res://resources/particles/water_burst.tscn")
var fx_hooked_burst := load("res://resources/particles/hooked_burst.tscn")

var stuck := false
var over_ground = false
var rod : RigidBody2D
var initial_mass = 0.3

var wait_unstuck  = 0.0

var time_till_catch = 0.0
var hooked = false
var has_fake_out = false
var time_hooked = 0.0

var hooked_total_time = 0.0

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

			var fx := fx_water_burst.instantiate() as CPUParticles2D
			fx.emitting = true
			fx.global_position = global_position
			rod.add_sibling(fx)

			if hooked:
				var fish = Spawner.get_fish()
				fish.launch_vector = global_position.direction_to(rod.global_position)
				fish.launch_distance = global_position.distance_to(rod.global_position)
				add_child(fish)
				Events.fish_caught.emit(fish.data)

				play_audio(sfx_come_up)
			else:
				play_audio(sfx_no_catch)

		else:
			wait_unstuck -= delta
			linear_velocity = Vector2()
			angular_velocity = 0

func _process(delta: float) -> void:
	if stuck :
		if not hooked:
			if time_till_catch > 0.0:
				time_till_catch -= delta

				if time_till_catch < 2.0 and has_fake_out:
					has_fake_out = false
					var fx := fx_hooked_burst.instantiate() as CPUParticles2D
					fx.emitting = true
					fx.global_position = global_position
					rod.add_sibling(fx)
					play_audio(sfx_fake_out)


			else:
				hooked = true
				var fx := fx_hooked_burst.instantiate() as CPUParticles2D
				fx.emitting = true
				fx.global_position = global_position
				rod.add_sibling(fx)
				hooked_total_time = 0.0 # reset so float goes down
				print("Bite!")
				play_audio(sfx_fish_bite)
		else:
			scale = Vector2(2, 2)
			time_hooked += delta

			if time_hooked > 1.0:
				hooked = false
				time_hooked = 0.0
				time_till_catch = randf_range(2.0, 4.0)
				hooked_total_time = hooked_total_time / 2.0

		hooked_total_time += delta
		var float_sprite = find_child("FloatSprite") as Sprite2D
		if not hooked:
			float_sprite.offset = Vector2(0, 2).rotated(-float_sprite.global_rotation) * sin(hooked_total_time * 4)
		else:
			float_sprite.offset = Vector2(0, 3).rotated(-float_sprite.global_rotation) * sin(hooked_total_time * 8)



func _on_body_entered(body):
	if body.has_meta("is_water") and body.get_meta("is_water") and not stuck:
		mass = 1000
		linear_velocity = Vector2()
		angular_velocity = 0

		wait_unstuck = 0.5
		stuck = true
		hooked = false
		hooked_total_time = 0.0
		has_fake_out = randi_range(1, 1) == 1;
		time_till_catch = randf_range(3.0, 8.0)
		print("Casting!")

		## AUDIO STUFF
		play_audio(sfx_hit_water)

		var fx := fx_hooked_burst.instantiate() as CPUParticles2D
		fx.emitting = true
		fx.global_position = global_position
		rod.add_sibling(fx)

		Events.float_cast.emit()


func play_audio(to_play: AudioStream) -> void:
	audio_stream_player_2d.stream = to_play
	audio_stream_player_2d.play()
