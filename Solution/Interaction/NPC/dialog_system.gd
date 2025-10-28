extends Control
class_name DialogSystem

@onready var panel : Panel = $Panel
@onready var label : Label = $Panel/Label
@export var player : Player

func _ready() -> void:
	panel.hide()

func toggle_dialog(dialog: String):
	if panel.visible:
		end_dialog()
	else :
		print_dialog(dialog)

func print_dialog(dialog : String):
	label.text = dialog
	panel.show()
	player.set_can_move(false)
	
func end_dialog():
	panel.hide()
	player.set_can_move(true)
