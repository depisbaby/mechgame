extends CharacterBody2D
class_name CursorManager

var trueMousePosition: Vector2
var xMousePositionInLevel: int
var yMousePositionInLevel: int
@export var tileCursor:Sprite2D

func _enter_tree():
	Global.cursorManager = self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	trueMousePosition = get_global_mouse_position()
	
	xMousePositionInLevel = roundf(trueMousePosition.x/16)
	yMousePositionInLevel = roundf(trueMousePosition.y/16)
	
	tileCursor.global_position = Vector2(xMousePositionInLevel * 16,yMousePositionInLevel * 16)
	
	#Select agent
	if Input.is_action_just_pressed("left"):
		var node:LevelNode = Global.gameManager.level.GetNodeAt(xMousePositionInLevel, yMousePositionInLevel)
		if node == null:
			return
		if node.agent == null:
			return
		Global.gameManager.SelectAgent(node.agent)
		
		
	
	pass
	
