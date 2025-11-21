extends Node
class_name AnimationManager

@export var animation_tree: AnimationTree
@export var character: CharacterBody2D = get_owner()

signal death_signal

var last_facing_direction := Vector2(0, -1)

func _physics_process(_delta: float) -> void:
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
	tween.tween_property($"../Sprite2D", "scale", Vector2(0.8, 0.8), 0.3).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property($"../Sprite2D", "modulate", Color.WHITE, 0.1).set_trans(Tween.TRANS_SINE)
	tween.tween_property($"../Sprite2D", "scale", Vector2(1, 1), 0.1).set_ease(Tween.EASE_IN)
	
func death_animation():
	var tween = get_tree().create_tween()
	tween.tween_property($"../Sprite2D", "modulate", Color.RED, 0.3).set_trans(Tween.TRANS_SINE)
	tween.tween_property($"../Sprite2D", "scale", Vector2(), 0.3).set_trans(Tween.TRANS_BOUNCE)
	await get_tree().create_timer(0.5).timeout
	emit_signal("death_signal")
	
