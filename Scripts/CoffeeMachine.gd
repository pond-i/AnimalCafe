extends InteractableItem

var coffee_on_station = 0
var coffee1_brewed = false
var coffee2_brewed = false
var coffee_ready = false

@onready var coffee1 = $Coffee
@onready var coffee2 = $Coffee2

func _ready() -> void:
	$Coffee.hide()
	$Coffee2.hide()
	
func Interact():
	if CurrentlyHolding.current_item == "CoffeeMugEmpty":
		var mug = GetMug()
		if mug == null: return
		mug.show()
		mug.set_modulate(Color(1, 1, 1, 1))
		mug.play("Empty")
		coffee_on_station += 1
		emit_signal("SendHand", "Empty")

	else:
		if CurrentlyHolding.current_item == "Empty" && coffee_on_station > 0:
			if(coffee1_brewed):
				$Coffee.hide()
				coffee_on_station -= 1
				coffee1_brewed = false
				emit_signal("SendHand", "CoffeeMugFull")
			elif(coffee2_brewed):
				$Coffee2.hide()
				coffee_on_station -= 1
				coffee2_brewed = false
				emit_signal("SendHand", "CoffeeMugFull")
		
func TurnOn(number):
	if (Input.is_action_just_pressed("left_click")):
		if coffee_on_station > 0 and number == 1:
			$Coffee.play("Filling")
		elif coffee_on_station > 1 and number == 2:
			$Coffee2.play("Filling")

func _on_area_2d_3_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	TurnOn(1)

func _on_area_2d_4_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	TurnOn(2)

func _on_coffee_animation_finished() -> void:
	coffee1_brewed = true
	coffee_ready = true
	
func _on_coffee_2_animation_finished() -> void:
	coffee2_brewed = true
	coffee_ready = true

func GetMug():
	var mug_number = null
	if(coffee_on_station == 0):
		mug_number = coffee1
		return mug_number
	elif coffee_on_station == 1:
		mug_number = coffee2
		return mug_number
	else:
		return

