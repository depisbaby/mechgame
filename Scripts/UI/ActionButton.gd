extends Node
class_name ActionButton

@export var id: int

func _on_pressed():
	%HUD.ActionPressed(id)
	pass # Replace with function body.
