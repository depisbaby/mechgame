extends Node
class_name HUD

@export var actionButtons : Array[ActionButton]
@export var agentInfo: Label
@export var messageBox: Label

func _enter_tree():
	Global.hud = self

	
func ActionPressed(actionName:String):
	Global.actionManager.ActionButtonPressed(actionName)
	pass

func UpdateAgentInfo(agent:Agent):
	if agent == null:
		agentInfo.text = ""
		return
	
	agentInfo.text = str(agent.agentName,"\nHP: ",agent.hp,"\nAP: ",agent.ap,"\nAmmo: ",agent.ammo)
	
	pass
	

func UpdateActions(agent:Agent):
	if agent == null:
		for button in actionButtons:
			button.hide()
		return
		
	var i:int = 0 
	for button in actionButtons:
		if i >= agent.possibleActions.size():
			button.hide()
			i=i+1
			continue
		
		var action = Global.actionManager.GetAction(agent.possibleActions[i])
		button.textRect.texture = action.icon
		button.actionName = action.actionName
		button.show()
		i=i+1
		
	
func UpdateMessageBox(message:String):
	messageBox.text = message
	pass
	
func UpdateEnemyInfo(agent:Agent):
	agentInfo.text = str("Enemy info\n",agent.agentName,"\nHP: ",agent.hp)
	UpdateActions(null)
	pass

func FlashMessage(message:String):
	var a = messageBox.text
	messageBox.text = message
	
	pass


func _on_pass_button_pressed():
	if !Global.battleManager.playerMayPerformActions:
		return
	Global.battleManager.playerPassing = true
	pass # Replace with function body.
