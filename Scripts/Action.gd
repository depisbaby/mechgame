extends Node
class_name Action

@export var actionName: String
@export var icon: Texture2D
@export var apCost: int

func PlayerStartPerforming(agent:Agent):
	Global.battleManager.playerMayPerformActions = false
	pass

func Perform(agent:Agent, targetPositionX:int, targetPositionY:int, args:String):
	agent.ap = agent.ap-apCost
	Global.hud.UpdateAgentInfo(agent)
	pass
	
func StopPerforming():
	Global.hud.UpdateMessageBox("Select an action to perform...")
	Global.battleManager.playerMayPerformActions = true
	
	pass

	
	
