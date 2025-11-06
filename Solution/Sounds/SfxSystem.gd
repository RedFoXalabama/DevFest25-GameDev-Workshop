extends Node
class_name SfxSystem

var rng = RandomNumberGenerator.new()

@onready var grass_steps : Node = $GrassSteps
@onready var sword_hits : Node = $SwordHits
@onready var hitsound : AudioStreamPlayer = $HitSound
var audio_steps : Array[AudioStreamPlayer] = []
var audio_sword : Array[AudioStreamPlayer] = []

func _ready() -> void:
	for step in grass_steps.get_children():
		audio_steps.append(step)
	for hits in sword_hits.get_children():
		audio_sword.append(hits)



var can_play_steps : bool = false
var is_playing_steps : bool = false

func random_step(value):
	var step = rng.randi_range(0,4)
	while step == value:
		step = rng.randi_range(0,4)
	if can_play_steps:
		audio_steps[step].play()

func play_grass_steps():
	can_play_steps = true
	if !is_playing_steps:
		is_playing_steps = true
		random_step(5)

func stop_grass_steps():
	can_play_steps = false
	is_playing_steps = false

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


var is_playing_sword : bool = false

func random_sword():
	var hit = rng.randi_range(0,4)
	audio_sword[hit].play()
		
func play_sword_hit():
	if !is_playing_sword:
		is_playing_sword = true
		random_sword()


var is_playing_hit : bool = false

func play_hit_sound():
	if !is_playing_hit:
		is_playing_hit = true
		hitsound.play()

func _on_hit_sound_finished() -> void:
	is_playing_hit = false
