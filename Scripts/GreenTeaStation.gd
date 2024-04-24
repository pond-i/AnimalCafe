extends InteractableItem

var cup_is_placed = false
var cup_is_full = false
@onready var coffee_mug = $Items/CoffeeMug
@onready var anime = $AnimationPlayer

func _ready() -> void:
	coffee_mug.hide()

func Interact():
	if anime.is_playing(): return
	
	if CurrentlyHolding.current_item == "CoffeeMugEmpty" && !cup_is_placed:
		cup_is_placed = true
		coffee_mug.show()
		coffee_mug.play("Empty")
		emit_signal("SendHand", "Empty")
		return
		
	if CurrentlyHolding.current_item == "Empty" && cup_is_placed && !cup_is_full:
		anime.play("Pour")
		cup_is_full = true
		return

	if CurrentlyHolding.current_item == "Empty" && cup_is_full:
		cup_is_full = false
		cup_is_placed = false
		coffee_mug.hide()
		$Items/GPUParticles2D.hide()
		emit_signal("SendHand", "GreenTeaFull")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Pour":
		$Items/GPUParticles2D.show()
