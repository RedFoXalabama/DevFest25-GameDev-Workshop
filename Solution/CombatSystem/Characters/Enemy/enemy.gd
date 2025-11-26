extends CharacterBody2D

signal killed

@export var life : int = 1
const SPEED = 100.0
var can_move : bool = true

var is_attacking : bool
var is_guarding : bool
var player_in_the_area : bool = false

var player : CharacterBody2D = null
@onready var animation_manager : AnimationManager = $AnimationManager
@onready var timer: Timer = $Timer

# MOVIMENTO IN BASE AL PLAYER
func _physics_process(_delta: float) -> void:
	if player: 
		var direction = (player.position - position).normalized()
		if direction && can_move:
			velocity = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
	velocity.normalized()

	move_and_slide()

func _on_search_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body

func _on_search_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = null

# LOGICA DANNI
func _on_hurt_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player hitbox"):
		if life > 1:
			animation_manager.get_damage()
			life -= 1
		elif life == 1:
			animation_manager.death_animation()


func _on_animation_manager_death_signal() -> void:
	emit_signal("killed")
	queue_free()


# ATTACK
func attack():
	is_attacking = true

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_move = false
		player_in_the_area = true
		attack()
		timer.start()

func _on_attack_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_move = true
		player_in_the_area = false
		timer.stop()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack1_left" || "attack1_right":
		is_attacking = false

func _on_timer_timeout() -> void:
	if player_in_the_area:
		attack()
