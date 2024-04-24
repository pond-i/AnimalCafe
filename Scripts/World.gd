extends Node2D

@onready var seats = $Main/TopSide/CustomerSpawner/Seats
@onready var customers = $Main/TopSide/Customers


func _ready() -> void:
	for i in customers.get_children():		
		await i.Arrive()
		#await get_tree().create_timer(4).timeout
	
