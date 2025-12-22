extends Node2D
class_name LevelNode

var xPos:int
var yPos:int
var floor: LevelFloor
var lobject: LevelObject
var agent: Agent
var closed: bool #used in GetPath()
var open: bool
