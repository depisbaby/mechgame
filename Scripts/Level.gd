extends Node
class_name Level

#const
@onready var levelNodePackedScene: PackedScene = preload("res://LevelObjects/LevelNode.tscn")
var nodes: Array[LevelNode]
var attackerDeploymentZone: Array[Vector2]
var defenderDeploymentZone: Array[Vector2]
@export var levelWidth: int
@export var levelHeight: int
var openNodes: Array[LevelNode]

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
	
	var i:int = 0
	for y in levelHeight:
		for x in levelWidth:
			var node: LevelNode = levelNodePackedScene.instantiate()
			add_child(node)
			nodes[i] = node
			node.global_position = Vector2(x*16,y*16)
			node.xPos = x
			node.yPos = y
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
		elif child is DeploymentZone:
			if child.attacker:
				attackerDeploymentZone.push_back(child.global_position)
			else:
				defenderDeploymentZone.push_back(child.global_position)
			child.queue_free()
		
		pass
			
	
	pass

## Get the level node at x,y. Returns null if out of bounds
func GetNodeAt(x:int,y:int)-> LevelNode: 
	if x < 0 || x >= levelWidth || y < 0 || y >= levelHeight:
		return null
	var i = y * levelWidth + x
	return nodes[i]
	pass
	
func GetNodeAtCursor()-> LevelNode:
	var x = Global.cursorManager.xMousePositionInLevel
	var y = Global.cursorManager.yMousePositionInLevel
	
	if x < 0 || x >= levelWidth || y < 0 || y >= levelHeight:
		return null
	var i = y * levelWidth + x
	return nodes[i]
	pass

func GetPath(startX:int,startY:int,endX:int,endY:int)->Array[Vector2]:
	var path: Array[Vector2]
	
	var startNode: LevelNode = GetNodeAt(startX,startY)
	OpenNeighbours(startNode)
	
	while(openNodes.size()!= 0&&):
		pass
	
	
	return path
	pass

func OpenNode(node:LevelNode):
	
	if node.open || node.closed:
		return
	
	if node.lobject !=null || node.agent != null:
		return
	
	openNodes.push_back(node)
	node.open = true
	pass

func OpenNeighbours(node:LevelNode):
	
	var _node:LevelNode = GetNodeAt(node.x,node.y-1)
	if _node != null:
		OpenNode(_node)
	
	_node= GetNodeAt(node.x+1,node.y-1)
	if _node != null:
		OpenNode(_node)
	
	_node= GetNodeAt(node.x+1,node.y)
	if _node != null:
		OpenNode(_node)
	
	_node= GetNodeAt(node.x+1,node.y+1)
	if _node != null:
		OpenNode(_node)
		
	_node= GetNodeAt(node.x,node.y+1)
	if _node != null:
		OpenNode(_node)
	
	_node= GetNodeAt(node.x-1,node.y+1)
	if _node != null:
		OpenNode(_node)
	
	_node= GetNodeAt(node.x-1,node.y)
	if _node != null:
		OpenNode(_node)
		
	_node= GetNodeAt(node.x-1,node.y-1)
	if _node != null:
		OpenNode(_node)
	
	pass
