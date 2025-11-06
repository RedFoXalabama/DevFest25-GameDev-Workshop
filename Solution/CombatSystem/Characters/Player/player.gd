extends CharacterBody2D
class_name Player

@export var animation_player := AnimationPlayer
@export var life : int = 3
@onready var animation_manager : AnimationManager = $AnimationManager
@onready var sfx_system : SfxSystem = $SfxSystem

const SPEED = 300.0
var can_move : bool = true
var direction : Vector2
var is_attacking : bool
var is_guarding : bool

func _physics_process(delta: float) -> void:
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	if direction && can_move:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
		sfx_system.play_grass_steps()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		sfx_system.stop_grass_steps()
	velocity.normalized()
	
	
	attacking()
	guarding()
	move_and_slide()

func set_can_move(value: bool):
	can_move = value

func attacking():
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		sfx_system.play_sword_hit()

func guarding():
	if Input.is_action_pressed("guard"):
		is_guarding = true
		velocity = Vector2.ZERO
	else :
		is_guarding = false


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack1_left" || "attack1_right":
		is_attacking = false
		sfx_system.is_playing_sword = false


func _on_hurt_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy hitbox"):
		if life > 1: 
			animation_manager.get_damage()
			sfx_system.play_hit_sound()
			life -= 1
		elif life == 1:
			animation_manager.death_animation()

func _on_animation_manager_death_signal() -> void:
	get_tree().change_scene_to_file("res://Solution/UI/EndScreen.tscn")
