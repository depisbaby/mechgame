extends Button
class_name ActionButton

@export var actionName: String
@export var textRect: TextureRect

func _on_pressed():
	#print("hoi")
	%HUD.ActionPressed(actionName)
	pass # Replace with function body.
