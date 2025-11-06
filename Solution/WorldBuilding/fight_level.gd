extends Node2D

var enemies_to_kill : int
var enemies_killed = 0

@onready var enemies : Node = $Enemies

func _ready() -> void:
	enemies_to_kill = enemies.get_child_count()
	for child in enemies.get_children():
		child.killed.connect(_on_killed_enemy)

func _on_killed_enemy():
	enemies_killed += 1
	if enemies_killed == enemies_to_kill:
		get_tree().change_scene_to_file("res://Solution/UI/EndScreen.tscn")
