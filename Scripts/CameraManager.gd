extends Camera2D

var inUse:bool
var targetPosition: Vector2
var cameraSpeed:float = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	global_position = Vector2(roundf(targetPosition.x), roundf(targetPosition.y))
	
	if !inUse:
		var mouse_pos = get_viewport().get_mouse_position()
		var viewport_size = get_viewport().get_visible_rect().size

		var at_left   = mouse_pos.x <= 10
		var at_right  = mouse_pos.x >= viewport_size.x - 10
		var at_top    = mouse_pos.y <= 10
		var at_bottom = mouse_pos.y >= viewport_size.y - 10

		if at_left:
			targetPosition = Vector2(targetPosition.x - delta*cameraSpeed, targetPosition.y)
			#print("left")
		if at_right:
			targetPosition = Vector2(targetPosition.x + delta*cameraSpeed, targetPosition.y)
			#print("right")
		if at_top:
			targetPosition = Vector2(targetPosition.x, targetPosition.y - delta*cameraSpeed)
			#print("top")
		if at_bottom:
			targetPosition = Vector2(targetPosition.x, targetPosition.y + delta*cameraSpeed)
			#print("bottom")
			
		pass
