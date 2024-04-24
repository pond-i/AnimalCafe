extends InteractableItem

var tempItem = null
var is_empty = true
var is_money = false

@onready var anime = $AnimationPlayer

signal SendItem(parameter)

func Interact():
	print("I placing item while holding: " + CurrentlyHolding.current_item)
	match CurrentlyHolding.current_item:
		"Empty":
			if(!is_empty && is_money):
				tempItem = "Empty"
				emit_signal("SendHand", "Money")
				Clear()
				is_money = false
				is_empty = true
			else:
				Clear()
				is_empty = true
				emit_signal("SendItem", "Empty")
				emit_signal("SendHand",tempItem)
		"CoffeeMugEmpty":
			$Items/CoffeeMug.show()
			Populate()
		"CoffeeMugFull":
			$Items/CoffeeMugFull.show()
			Populate()
		"Muffin1":
			$Items/Muffin1.show()
			Populate()
		"Muffin2":
			$Items/Muffin2.show()
			Populate()
		"Muffin1Cooked":
			$Items/Muffin1Cooked.show()
			Populate()
		"Muffin2Cooked":
			$Items/Muffin2Cooked.show()
			Populate()
		"GreenTeaFull":
			$Items/GreenTea.show()
			Populate()
		"Money":
			pass

func Clear():
	for i in $Items.get_children():
		i.hide()
			
func ClearPlate():
	Clear()
	is_empty = false
	is_money = true
	await get_tree().create_timer(2).timeout
	anime.play("CashMoney")
	
func Populate():
	tempItem = CurrentlyHolding.current_item
	is_empty = false
	print("sending signal with: " + tempItem)
	emit_signal("SendHand","Empty")
	emit_signal("SendItem", tempItem)

func _on_customer_clear_plate() -> void:
	ClearPlate()
