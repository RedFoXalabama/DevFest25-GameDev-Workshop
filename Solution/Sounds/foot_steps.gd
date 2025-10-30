extends Node
class_name FootSteps

var rng = RandomNumberGenerator.new()

@onready var grass_step_0 : AudioStreamPlayer = $GrassStep0
@onready var grass_step_1 : AudioStreamPlayer = $GrassStep1
@onready var grass_step_2 : AudioStreamPlayer = $GrassStep2
@onready var grass_step_3 : AudioStreamPlayer = $GrassStep3
@onready var grass_step_4 : AudioStreamPlayer = $GrassStep4
var audio_steps : Array[AudioStreamPlayer] 

func _ready() -> void:
	audio_steps = [grass_step_0, grass_step_1, grass_step_2, grass_step_3, grass_step_4]

var can_play_sound : bool = false
var is_playing : bool = false

func random_step(value):
	var step = rng.randi_range(0,4)
	while step == value:
		step = rng.randi_range(0,4)
	if can_play_sound:
		audio_steps[step].play()

func play():
	can_play_sound = true
	if !is_playing:
		is_playing = true
		random_step(5)

func stop():
	can_play_sound = false
	is_playing = false

func _on_grass_step_0_finished() -> void:
	random_step(0)

func _on_grass_step_1_finished() -> void:
	random_step(1)

func _on_grass_step_2_finished() -> void:
	random_step(2)

func _on_grass_step_3_finished() -> void:
	random_step(3)

func _on_grass_step_4_finished() -> void:
	random_step(4)
