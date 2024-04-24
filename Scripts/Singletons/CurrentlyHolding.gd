extends Node

var current_item = null

func Update(item):
	current_item = item
	
func Return():
	return current_item	
