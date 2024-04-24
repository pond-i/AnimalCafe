extends CharacterBody2D

const SPEED = 300.0
var walking = false

@onready var anime = $AnimatedSprite2D
@onready var back_items = $"../BackItems"
@onready var front_items = $"../TopSide/FrontItems"

func _ready() -> void:
	CurrentlyHolding.current_item = "Empty"

func _physics_process(_delta: float) -> void:

	var direction := Input.get_axis("Left", "Right")
	
	if (Input.is_action_just_pressed("right_click")):
		EmptyHands()
			
	if(Input.is_action_just_pressed("Left")):
		anime.flip_h = false
	
	if(Input.is_action_just_pressed("Right")):
		anime.flip_h = true
	
	if direction:
		velocity.x = direction * SPEED
		walking = true
		anime.play("Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		walking = false
		anime.play("Ide")
	move_and_slide()
	
	if CurrentlyHolding.current_item == "Empty":
		$PawsUP.hide()
		$PawsDown.show()
		ClearAllHeldItems()
	else:
		$PawsUP.show()
		$PawsDown.hide()

func EmptyHands():
	CurrentlyHolding.Update("Empty")
	ClearAllHeldItems()

func ChangeItems(item):
	for i in $Items.get_children():
		if i.name == item:
			ClearAllHeldItems()
			CurrentlyHolding.current_item = item
			print(item)
			i.show()
			break

func ClearAllHeldItems():
	for i in $Items.get_children():
			i.hide()
	CurrentlyHolding.current_item = "Empty"
	
func signal_coffee_mug(state) -> void:
	if CurrentlyHolding.current_item != "Empty": return
	ClearAllHeldItems()
	if(state):
		# Coffee is full
		ChangeItems("CoffeeMugFull")
	else:
		# Coffee is empty
		ChangeItems("CoffeeMugEmpty")

# Coffee Mug
func _on_coffee_mug_send_hand(parameter) -> void:
	if parameter == "Empty":
		EmptyHands()
		return

# Coffee Machine
func _on_coffee_machine_send_hand(parameter) -> void:
	if parameter == "Empty":
		EmptyHands()
		return
	if parameter == "CoffeeMugFull":
		ChangeItems(parameter)

# Treat Shelf
func _on_treat_shelf_send_hand(parameter) -> void:
	if parameter == "Empty":
		EmptyHands()
		return
		
	if CurrentlyHolding.current_item == "Empty":
		match parameter:
			"Muffin1":
				ChangeItems("Muffin1")
			"Muffin2":
				ChangeItems("Muffin2")

# Placemat
func _on_placemat_send_hand(parameter) -> void:
	if parameter == "Empty":
		EmptyHands()
		return
	ChangeItems(parameter)

func _on_oven_send_hand(parameter) -> void:
	if parameter == "Empty":
		EmptyHands()
		return
	ChangeItems(parameter)

func _on_green_tea_station_send_hand(parameter) -> void:
	if parameter == "Empty":
		EmptyHands()
		return
	ChangeItems(parameter)

func _on_cash_register_send_hand(parameter) -> void:
	if parameter == "Empty":
		EmptyHands()
		return


func _on_mouse_entered() -> void:
	pass # Replace with function body.
