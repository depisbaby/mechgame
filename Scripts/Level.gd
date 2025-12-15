extends Node
class_name Level

#const
@onready var levelNodePackedScene: PackedScene = preload("res://LevelObjects/LevelNode.tscn")
var spriteSize:int = 16

var nodes: Array[LevelNode]
@export var levelWidth: int
@export var levelHeight: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

##Call this to fully generate the level to be used in game
func PrepareLevel(
):
	print("Preparing level")
	
	nodes.resize(levelWidth*levelHeight)
	
	var i:int
	for y in levelHeight:
		for x in levelWidth:
			var node: LevelNode = levelNodePackedScene.instantiate()
			add_child(node)
			nodes[i] = node
			node.global_position = Vector2(x*16,y*16)
			i=i+1
	
	for child:Node2D in get_children():
		var x:int = roundf(child.global_position.x / 16)
		var y:int = roundf(child.global_position.y / 16)
		if child is LevelFloor:
			var j = y * levelWidth + x
			nodes[j].floor = child
		elif child is LevelObject:
			var j = y * levelWidth + x
			nodes[j].lobject = child
		
		pass
			
	
	pass

## Get the level node at x,y. Returns null if out of bounds
func GetNodeAt(x:int,y:int)-> LevelNode: 
	if x < 0 || x >= levelWidth || y < 0 || y >= levelHeight:
		return null
	var i = y * levelWidth + x
	return nodes[i]
	pass
