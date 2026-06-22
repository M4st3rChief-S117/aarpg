# This script now has a name that can be accessed from other scripts when needed
class_name Player extends CharacterBody2D

	# Vector2 is a variable that contains 2 values, x, y
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.Initialize(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	# direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	# normalized, prevents the vector from having the magnitude > 1, so when moving diagonally it isn't faster
	#direction = direction.normalized()
	
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()

func SetDirection() -> bool:
	var new_dir : Vector2 = cardinal_direction
	
	# If the player is idle he's gonna stay the direction he was facing before
	if direction == Vector2.ZERO:
		return false
	
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
		
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	
	return true
	
func UpdateAnimation( state : String) -> void:
	animation_player.play(state + "_" + AnimDirection())	
	pass

func AnimDirection () -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
	
	
	
	
	
	
