extends InteractableItem

var is_in_hand = false
var state = false

func Interact():
	if CurrentlyHolding.current_item == "CoffeeMugEmpty":
		emit_signal("SendHand", "Empty")
		return
	print("coffee mug")
	emit_signal("CoffeeMugPickUp", false)

signal CoffeeMugPickUp(state)
