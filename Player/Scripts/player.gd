# This script now has a name that can be accessed from other scripts when needed
class_name Player extends CharacterBody2D

var move_speed : float = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Vector2 is a variable that contains 2 values, x, y
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	velocity = direction * move_speed
	
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()
