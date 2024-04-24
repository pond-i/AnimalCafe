extends InteractableItem

var is_open = false
var item_in_oven = false
var oven_start = false
var item_cooked = false

func Interact():
	if oven_start: return
	if $AnimatedSprite2D.is_playing(): return
	
	if(is_open):
		for item in $Items.get_children():
			# Put item in oven
			if CurrentlyHolding.current_item == item.name && !item_in_oven:
				item.show()
				item_in_oven = true
				emit_signal("SendHand", "Empty")
				return
			
		if CurrentlyHolding.current_item == "Empty" && item_in_oven && !item_cooked:
			# Close
			$AnimatedSprite2D.play_backwards("Open")
			is_open = false
			var item = FindItem()
			var tween = get_tree().create_tween()
			tween.tween_property(item, "modulate", Color(1, 1, 1, 0.2), .5)
			Start()
			return
	
	# If Closed
	if !is_open:
		$AnimatedSprite2D.play("Open")
		is_open = true
		return
		
	
	if(is_open && item_in_oven && CurrentlyHolding.current_item == "Empty" && item_cooked && item_in_oven):
		var item = FindItem()
		emit_signal("SendHand", item.name + "Cooked")
		HideItem()
		item_in_oven = false
		item_cooked = false
		return

func FindItem():
	for item in $Items.get_children():
		if item.is_visible():
			return item	
	
func HideItem():
	for item in $Items.get_children():
		item.hide()

func Start():
	oven_start = true
	await get_tree().create_timer(4.0).timeout
	oven_start = false
	is_open = true
	$AnimatedSprite2D.play("Open")
	var item = FindItem()
	var tween = get_tree().create_tween()
	tween.tween_property(item, "modulate", Color(1, 0.4, 0.8, 1), .5)
	item_cooked = true
