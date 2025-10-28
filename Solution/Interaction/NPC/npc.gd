extends StaticBody2D

@export var dialogSystem : DialogSystem
@export_multiline var dialog : String
var player_in_area : bool

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") && player_in_area:
		dialogSystem.toggle_dialog(dialog)

func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_area = true

func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_area = false
