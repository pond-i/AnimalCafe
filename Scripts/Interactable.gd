extends Node2D
class_name InteractableItem

var paw = load("res://Sprites/UI/cursor_point.png")
var interact = load("res://Sprites/UI/cursor_interact.png")
var player_in_zone = false

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_zone = true

func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_zone = false

func _on_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if (Input.is_action_just_pressed("left_click")):
		if player_in_zone:
			Interact()

func Interact():
	pass
	
signal SendHand(parameter)

func _on_area_2d_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_area_2d_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
