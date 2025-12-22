extends Node
class_name ActionManager

@export var actions: Array[Action]
@export var actionHelperTilePackedScene :PackedScene
var actionHelperTiles: Array[Sprite2D]

func _enter_tree():
	Global.actionManager = self

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 100:
		var helperTile: Sprite2D = actionHelperTilePackedScene.instantiate()
		add_child(helperTile)
		actionHelperTiles.push_back(helperTile)
		helperTile.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func GetAction(name:String)->Action:
	for action in actions:
		if action.actionName == name:
			return action
	return null
	pass

func ShowHelperTile(x:int, y:int):
	for tile in actionHelperTiles:
		if !tile.visible:
			tile.global_position = Vector2(16*x, 16*y)
			tile.show()
			return
	pass

func HideHelpers():
	for tile in actionHelperTiles:
		if tile.visible:
			tile.hide()
		else:
			return
	pass
	
func ActionButtonPressed(actionName:String):
	if !Global.battleManager.playerMayPerformActions:
		return
	
	if Global.battleManager.selectedAgent != Global.battleManager.activatedAgent:
		return
		
	
	
	for action:Action in actions:
		if action.actionName == actionName:
			if action.apCost > Global.battleManager.activatedAgent.ap:
				return
			action.PlayerStartPerforming(Global.battleManager.selectedAgent)
	
	pass
