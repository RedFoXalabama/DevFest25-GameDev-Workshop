extends Node
class_name AnimationManager

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

func get_damage():
	var tween = get_tree().create_tween()
	tween.tween_property($"../Sprite2D", "modulate", Color.RED, 0.3).set_trans(Tween.TRANS_SINE)
	tween.tween_property($"../Sprite2D", "scale", Vector2(), 0.3).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_callback($"../Sprite2D".queue_free)
	
