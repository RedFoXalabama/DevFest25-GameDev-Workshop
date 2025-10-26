extends CharacterBody2D

@export var animation_player := AnimationPlayer
@export var life : int = 3
@onready var animation_manager : AnimationManager = $AnimationManager

const SPEED = 300.0

var direction : Vector2
var is_attacking : bool
var is_guarding : bool

func _physics_process(delta: float) -> void:
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	velocity.normalized()
	
	
	attacking()
	guarding()
	move_and_slide()


func attacking():
	if Input.is_action_just_pressed("attack"):
		is_attacking = true

func guarding():
	if Input.is_action_pressed("guard"):
		is_guarding = true
		velocity = Vector2.ZERO
	else :
		is_guarding = false


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack1_left" || "attack1_right":
		is_attacking = false


func _on_hurt_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy hitbox"):
		if life > 1: 
			animation_manager.get_damage()
			life -= 1
		elif life == 1:
			animation_manager.death_animation()

func _on_animation_manager_death_signal() -> void:
	pass
