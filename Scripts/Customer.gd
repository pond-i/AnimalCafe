extends Node2D

@onready var speech_label = $SpeechLabel
@onready var anime = $AnimationPlayer
@export var table_number: int
@export var table_position: Marker2D
@onready var sprite_array = [preload("res://Sprites/Characters/MrFox.png"),
						preload("res://Sprites/Characters/MissRabbit.png"),
						preload("res://Sprites/Characters/MrOwl.png"),
						preload("res://Sprites/Characters/MrMouse.png")]

var item_array = ["CoffeeMugFull",
				"GreenTeaFull",
				"Muffin1",
				"Muffin2",
				"Muffin1Cooked",
				"Muffin2Cooked"]
				
var happy_array = ["Yummy!",
					"it's the best!", 
					"That's cash money!",
					"Thank you!",
					"Yummers!", 
					"WOW!"]

var placed_item = null
var is_active = false

signal ClearPlate()

func Arrive():
	is_active = true
	var picked_sprite = sprite_array[randi() % sprite_array.size()]
	$Sprite.set_texture(picked_sprite)
	$Sprite.z_index = 0
	$SpeechBubble.z_index = 0
	$SpeechBubble.hide()
	for x in $SpeechBubble/Items.get_children():
		x.hide()

	# Walk to seat
	self.position = Vector2(329, 939)
	var tween = get_tree().create_tween()
	
	# Get on seat
	tween.tween_property(self, "position", table_position.position - Vector2(0, -70), 4)
	await tween.finished
	anime.stop()
	
	GenerateOrder()
	
	tween.stop()
	tween.play()
	tween.tween_property(self, "position", table_position.position, .2)
	await tween.finished
	$SpeechBubble/Items.show()
	$SpeechBubble.show()
	anime.play("Open")

func Leave():
	$Sprite.z_index = 1
	$SpeechBubble.z_index = 1
	$SpeechBubble/Items.hide()
	anime.play_backwards("Open")
	speech_label.text = ""
	await get_tree().create_timer(2).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", self.position - Vector2(0, -70), .2)
	await tween.finished
	anime.play("Walk")
	tween.stop()
	tween.play()
	tween.tween_property(self, "position", Vector2(1900, 939), 4)
	is_active = false
	var rng = RandomNumberGenerator.new()
	var number = rng.randf_range(5, 15)
	await get_tree().create_timer(number).timeout
	Arrive()

func GenerateOrder():
	var picked_item = item_array[randi() % item_array.size()]
	print("I am table number: " + str(table_number) + ". I want " + picked_item)
	placed_item = picked_item

	for x in $SpeechBubble/Items.get_children():
		if x.name == picked_item:
			x.show()
			break

func PlaceItem(item):
	#print("placing " + item + " when I wanted " + placed_item)
	if item == placed_item:
		var picked_quote = happy_array[randi() % happy_array.size()]
		speech_label.text = picked_quote
		$SpeechBubble/Items.hide()
		speech_label.show()
		await get_tree().create_timer(4).timeout
	
		emit_signal("ClearPlate")
		Leave()
	else:
		$SpeechBubble/Items.hide()
		speech_label.show()
		if "Cooked" in placed_item:
			speech_label.text = "Heated PLEASE"
		else:
			speech_label.text = "I didn't order this.."
		await get_tree().create_timer(4).timeout
		speech_label.text = ""
		$SpeechBubble/Items.show()

func _on_placemat_send_item(parameter) -> void:
	print("sent from customer 1: + " + parameter)
	speech_label.text = parameter
	PlaceItem(parameter)

func _on_placemat_2_send_item(parameter) -> void:
	print("sent from customer 2: + " + parameter)
	speech_label.text = parameter
	PlaceItem(parameter)
	
func _on_placemat_3_send_item(parameter) -> void:
	print("sent from customer 3: + " + parameter)
	speech_label.text = parameter
	PlaceItem(parameter)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name == "Open"):
		anime.play("speech_float")
		
	if(anim_name == "Walk"):
		anime.play("Chill")
