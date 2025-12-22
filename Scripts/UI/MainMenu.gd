extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	show()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	Global.gameManager.StartBattle()
	hide()
	pass # Replace with function body.
