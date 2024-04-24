extends InteractableItem

# If true; muffin 1, else muffin 2
var muffin_type = false

func Interact():
	muffin_type = false
	emit_signal("SendHand","Muffin1")

func InteractSecond():
	muffin_type = true
	
func _on_area_2d_3_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if (Input.is_action_just_pressed("left_click")):
		if player_in_zone:
			InteractSecond()
			emit_signal("SendHand","Muffin2")
