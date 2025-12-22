extends Node
class_name BattleManager

var selectedAgent: Agent
var playersTurn: bool
var agents: Array[Agent]
var friendlyAgents: Array[Agent]
var enemyAgents: Array[Agent]
var activatedAgent: Agent
var playerPassing: bool
var playerMayPerformActions: bool

func _enter_tree():
	Global.battleManager = self

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func SpawnAgent(id:int, x:int, y:int, playerControlled:bool):
	
	var node : LevelNode = Global.gameManager.level.GetNodeAt(x,y)
	if node.agent != null:
		return
	
	var agent: Agent = Global.gameManager.agents[id].instantiate()
	add_child(agent)
	agent.global_position = Vector2(x*16,y*16)
	agent.playerControlled = playerControlled
	agent.xPos = x
	agent.yPos = y
	node.agent = agent
	
	
	agents.push_back(agent)
	if agent.playerControlled:
		friendlyAgents.push_back(agent)
	else:
		enemyAgents.push_back(agent)
	pass

func SelectAgent(agent:Agent):
	
	if !agent.playerControlled:
		Global.hud.UpdateEnemyInfo(agent)
		return
	
	if selectedAgent == agent && activatedAgent == null && playersTurn:
		PlayerActivateAgent(agent)
	
	Global.hud.UpdateActions(agent)
	Global.hud.UpdateAgentInfo(agent)
	selectedAgent = agent
	
	pass
	
func StartBattle():
	
	#spawn test enemy
	SpawnAgent(0,roundf(Global.gameManager.level.attackerDeploymentZone[0].x/16),roundf(Global.gameManager.level.attackerDeploymentZone[0].y/16),false)
	SpawnAgent(0,roundf(Global.gameManager.level.attackerDeploymentZone[1].x/16),roundf(Global.gameManager.level.attackerDeploymentZone[1].y/16),false)
	SpawnAgent(0,roundf(Global.gameManager.level.attackerDeploymentZone[2].x/16),roundf(Global.gameManager.level.attackerDeploymentZone[2].y/16),false)
	
	#spawn test friendly
	SpawnAgent(0,roundf(Global.gameManager.level.defenderDeploymentZone[0].x/16),roundf(Global.gameManager.level.defenderDeploymentZone[0].y/16),true)
	SpawnAgent(0,roundf(Global.gameManager.level.defenderDeploymentZone[1].x/16),roundf(Global.gameManager.level.defenderDeploymentZone[1].y/16),true)
	SpawnAgent(0,roundf(Global.gameManager.level.defenderDeploymentZone[2].x/16),roundf(Global.gameManager.level.defenderDeploymentZone[2].y/16),true)
	
	playersTurn = true #sets the first turn to be player's
	while(true):
		
		for agent in agents:
			agent.ap = agent.startingAp
			agent.activated = false
	
		while(true):#turn cycle
			var allActivated: bool = true
			for agent in agents:
				if !agent.activated:
					allActivated = false
			if allActivated:
				break
			await StartTurn()
			playersTurn = !playersTurn
		
		Global.hud.UpdateMessageBox("All agents activated! The battle continues...")
		await get_tree().create_timer(5.0).timeout
	
	pass
	
func StartTurn():
	
	#activation
	activatedAgent = null
	if playersTurn:
		PlayerStartActivateAgent()
	else:
		Global.cpu.ActivateAgent()
		
	while(activatedAgent == null): #wait until player selects an agent to activate
		await get_tree().process_frame
	
	for i in friendlyAgents:
		if !i.activated:
			i.activateIcon.hide()
	
	#do actions
	playerPassing = false
	if playersTurn:
		PlayerStartPerformActions()
	else:
		Global.cpu.PerformAction()
	
	while(!playerPassing): #wait until player has done everything with the activated agent
		await get_tree().process_frame
	
	playerMayPerformActions = false
	playerPassing = false
	activatedAgent = null
	
	pass

func PlayerStartActivateAgent():
	Global.hud.UpdateMessageBox("Your turn. Select a friendly operative to activate...")
	Global.hud.UpdateActions(null)
	Global.hud.UpdateAgentInfo(null)
	selectedAgent = null	
	
	for i in friendlyAgents:
		if !i.activated:
			i.activateIcon.show()
	
	pass

func PlayerActivateAgent(agent):
	activatedAgent = agent
	agent.activated = true
	for i in friendlyAgents:
		i.activateIcon.hide()
	SelectAgent(agent)

func PlayerStartPerformActions():
	Global.hud.UpdateMessageBox("Select an action to perform...")
	playerMayPerformActions = true
	pass
