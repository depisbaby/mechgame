extends Node
class_name CPU

func _enter_tree():
	Global.cpu = self

func ActivateAgent():
	
	#temp pick random
	var agents: Array[Agent]
	for i:Agent in Global.battleManager.enemyAgents:
		if !i.activated:
			agents.push_back(i)
	agents.shuffle()
	
	Global.hud.UpdateMessageBox(str("They are activating ",agents[0].agentName, "!"))
	await get_tree().create_timer(3.0).timeout
	
	Global.battleManager.activatedAgent = agents[0]
	Global.battleManager.activatedAgent.activated = true
	pass

func PerformAction():
	
	# test
	Global.hud.UpdateMessageBox(str("They are scratching their balls!"))
	await get_tree().create_timer(3.0).timeout
	Global.battleManager.activatedAgent.ap = 0
	Global.battleManager.playerPassing = true
	
	
	pass
