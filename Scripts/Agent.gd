extends Node2D
class_name Agent

@export var possibleActions: Array[String]
@export var agentName: String
@export var activateIcon : Sprite2D
@export var startingAp:int

var playerControlled: bool
var hp: int
var ap: int
var ammo: int
var activated: bool
var xPos: int
var yPos: int

func _ready():
	agentName = str("test", randi())
	pass
