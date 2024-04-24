extends InteractableItem

@onready var register = $register_sprite
@onready var anime = $AnimationPlayer
var is_open = false

func Interact():
	if anime.is_playing(): return
	if CurrentlyHolding.current_item == "Money":
			emit_signal("SendHand", "Empty")
			register.play("Open")
			anime.play("Ding")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name == "Ding"):
		register.play_backwards("Open")
