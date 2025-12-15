extends Node
class_name GameManager

@export var levels: Array[PackedScene]
var level: Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	LoadLevel(0)
	pass # Replace PrepareLevel()h function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	##Load the level, including level objects, etc. Does not start the game.
func LoadLevel(levelId:int):
	var level:Level = levels[levelId].instantiate()
	add_child(level)
	level.PrepareLevel()
	pass
