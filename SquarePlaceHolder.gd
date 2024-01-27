extends Panel
class_name TicTacToePanel

var current_value = ""


var is_selected:bool = false

func _on_mouse_entered():
	if not is_selected:
		$Label.text = Variables.PlayerMark
		$Label.show()
		pass # Replace with function body.

func _on_mouse_exited():
	if not is_selected:
		$Label.hide()
		pass # Replace with function body.
	pass # Replace with function body.


func _on_gui_input(event):
	if (event.is_pressed()):
		if (event.button_index == MOUSE_BUTTON_LEFT):
			if not is_selected:
				is_selected = true
				current_value = Variables.PlayerMark
				Variables.update_game.emit()
				Variables.next_turn.emit()
	pass # Replace with function body.

func reset():
	current_value = ""
	is_selected = false
	$Label.text = ""
