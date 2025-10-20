extends Node

@export var animation_tree: AnimationTree
@export var character: CharacterBody2D = get_owner()

var last_facing_direction := Vector2(0, -1)

func _physics_process(delta: float) -> void:
	var idle = !character.velocity
	
	if !idle:
		last_facing_direction = character.velocity.normalized()
	
	animation_tree.set("parameters/Idle/blend_position", last_facing_direction.normalized())
	animation_tree.set("parameters/Run/blend_position", last_facing_direction.normalized())
	animation_tree.set("parameters/Attack1/blend_position", last_facing_direction.normalized())
	animation_tree.set("parameters/Guard/blend_position", last_facing_direction.normalized())
