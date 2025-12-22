extends Action
var possibleNodes: Array[LevelNode] 


func PlayerStartPerforming(agent:Agent):
	super.PlayerStartPerforming(agent) ##ALWAYS HERE
	Global.hud.UpdateMessageBox("Choose a tile to reposition to...\nRight click to cancel...")
	GetPossiblePositions(agent)
	
	while true:
		if Input.is_action_just_pressed("left"):
			var node:LevelNode = Global.gameManager.level.GetNodeAtCursor()
			if possibleNodes.has(node):
				Perform(agent,node.xPos,node.yPos,"")
				return
			
		elif  Input.is_action_just_pressed("right"):#cancel
			possibleNodes.clear()
			StopPerforming()
			return
			
		await get_tree().process_frame
		
	
	pass

func Perform(agent:Agent, targetPositionX:int, targetPositionY:int, args:String):
	super.Perform(agent, targetPositionX, targetPositionY, args)
	Global.actionManager.HideHelpers()
	Global.hud.UpdateMessageBox(str(agent.agentName," is performing Reposition..."))
	
	var targetPosition: Vector2 = Vector2(targetPositionX*16,targetPositionY*16)
	
	while((targetPosition - agent.global_position).length() > 0.1):
		agent.global_position = agent.global_position.move_toward(targetPosition, get_process_delta_time()*20)
		await get_tree().process_frame
		pass
	
	agent.global_position = targetPosition
	var startNode = Global.gameManager.level.GetNodeAt(agent.xPos,agent.yPos)
	startNode.agent = null
	var node = Global.gameManager.level.GetNodeAt(targetPositionX,targetPositionY)
	node.agent = agent
	agent.xPos = targetPositionX
	agent.yPos = targetPositionY
	
	possibleNodes.clear()
	StopPerforming()
	pass
	
func GetPossiblePositions(agent:Agent):
	var node = Global.gameManager.level.GetNodeAt(agent.xPos, agent.yPos+1)
	if node != null:
		if node.lobject == null && node.agent == null:
			possibleNodes.push_back(node)
			Global.actionManager.ShowHelperTile(node.xPos,node.yPos)
		
	node = Global.gameManager.level.GetNodeAt(agent.xPos+1, agent.yPos+1)
	if node != null:
		if node.lobject == null && node.agent == null:
			possibleNodes.push_back(node)
			Global.actionManager.ShowHelperTile(node.xPos,node.yPos)
	
	node = Global.gameManager.level.GetNodeAt(agent.xPos+1, agent.yPos)
	if node != null:
		if node.lobject == null && node.agent == null:
			possibleNodes.push_back(node)
			Global.actionManager.ShowHelperTile(node.xPos,node.yPos)
	
	node = Global.gameManager.level.GetNodeAt(agent.xPos+1, agent.yPos-1)
	if node != null:
		if node.lobject == null && node.agent == null:
			possibleNodes.push_back(node)
			Global.actionManager.ShowHelperTile(node.xPos,node.yPos)
	
	node = Global.gameManager.level.GetNodeAt(agent.xPos, agent.yPos-1)
	if node != null:
		if node.lobject == null && node.agent == null:
			possibleNodes.push_back(node)
			Global.actionManager.ShowHelperTile(node.xPos,node.yPos)
	
	node = Global.gameManager.level.GetNodeAt(agent.xPos-1, agent.yPos-1)
	if node != null:
		if node.lobject == null && node.agent == null:
			possibleNodes.push_back(node)
			Global.actionManager.ShowHelperTile(node.xPos,node.yPos)
			
	node = Global.gameManager.level.GetNodeAt(agent.xPos-1, agent.yPos)
	if node != null:
		if node.lobject == null && node.agent == null:
			possibleNodes.push_back(node)
			Global.actionManager.ShowHelperTile(node.xPos,node.yPos)
			
	node = Global.gameManager.level.GetNodeAt(agent.xPos-1, agent.yPos+1)
	if node != null:
		if node.lobject == null && node.agent == null:
			possibleNodes.push_back(node)
			Global.actionManager.ShowHelperTile(node.xPos,node.yPos)
	pass
