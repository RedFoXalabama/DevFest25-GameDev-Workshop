extends Node

@export var soundtrack_name : String

func _ready() -> void:
	get_node(soundtrack_name).play()		
	
