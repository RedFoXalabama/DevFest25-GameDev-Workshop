extends CharacterBody2D

const SPEED = 100.0
var player : CharacterBody2D = null
@onready var animation_manager : AnimationManager = $AnimationManager

func _physics_process(delta: float) -> void:
	if player: 
		var direction = (player.position - position).normalized()
		if direction:
			velocity = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()


func _on_search_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body


func _on_hurt_area_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Player" && area.name == "HitArea":
		animation_manager.get_damage()
		
		
