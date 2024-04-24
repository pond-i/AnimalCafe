extends InteractableItem


@onready var mug = $Sprite2D

func _ready() -> void:
	mug.hide()

func _process(_delta: float) -> void:
	if !player_in_zone:
		mug.hide()

func _on_area_2d_mouse_entered() -> void:
	if(CurrentlyHolding.current_item == "CoffeeMugEmpty" && player_in_zone):
		var tween = get_tree().create_tween()
		mug.set_modulate(Color(1, 1, 1, 0))
		mug.show()
		tween.tween_property(mug, "modulate", Color(1, 1, 1, 0.2), 0.1)
		await get_tree().create_timer(3.0).timeout
		mug.hide()

func _on_area_2d_mouse_exited() -> void:
	if(CurrentlyHolding.current_item == "CoffeeMugEmpty" && player_in_zone):
		var tween = get_tree().create_tween()
		mug.show()
		tween.tween_property(mug, "modulate", Color(1, 1, 1, 0), 0.1)
