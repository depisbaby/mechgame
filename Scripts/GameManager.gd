extends Node
class_name GameManager

@export var levels: Array[PackedScene]
@export var agents: Array[PackedScene]
var level: Level
var inGame: bool


func _enter_tree():
	Global.gameManager = self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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

#this starts a new battle
func StartBattle():
	if inGame:
		return
	inGame = true
	#await get_tree().create_timer(20.0).timeout
	LoadLevel(0)
	Global.battleManager.StartBattle()
	pass
	
