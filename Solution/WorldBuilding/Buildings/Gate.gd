extends StaticBody2D

@export var destination : PackedScene

var player_in_area : bool

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") && player_in_area:
		get_tree().change_scene_to_packed(destination)

func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_area = true

func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_area = false
