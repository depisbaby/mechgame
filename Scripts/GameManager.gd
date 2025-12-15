extends Node
class_name GameManager

@export var levels: Array[PackedScene]
@export var agents: Array[PackedScene]
var level: Level
var selectedAgent: Agent

func _enter_tree():
	Global.gameManager = self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	LoadLevel(0)
	await get_tree().create_timer(1.0).timeout
	SpawnAgent(0,0,0,true)
	pass # Replace PrepareLevel()h function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	##Load the level, including level objects, etc. Does not start the game.
func LoadLevel(levelId:int):
	var _level:Level = levels[levelId].instantiate()
	add_child(_level)
	level = _level
	_level.PrepareLevel()
	pass
	
func SelectAgent(agent:Agent):
	print("hep")
	pass


func SpawnAgent(id:int, x:int, y:int, playerControlled:bool):
	
	var node : LevelNode = Global.gameManager.level.GetNodeAt(x,y)
	if node.agent != null:
		return
	
	var agent: Agent = agents[id].instantiate()
	add_child(agent)
	agent.global_position = Vector2(x*16,y*16)
	agent.playerControlled = playerControlled
	node.agent = agent
	pass
