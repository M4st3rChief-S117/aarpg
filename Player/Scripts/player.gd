# This script now has a name that can be accessed from other scripts when needed
class_name Player extends CharacterBody2D

	# Vector2 is a variable that contains 2 values, x, y
var cardinal_direction : Vector2 = Vector2.DOWN
const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]
var direction : Vector2 = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

signal DirectionChanged( new_direction: Vector2 )

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
	# If the player is idle he's gonna stay the direction he was facing before
	if direction == Vector2.ZERO:
		return false
	
	# angle / TAU = number from 0 to 1, getting an angle and make sure that it only relates to one of the directions
	# (direction +sss cardinal_direction * 0.1) Gives a directon, but it skews it a bit over the cardinal direction, it favors the direction already facing when pressing multiple keys
	var direction_id : int = int ( round( ( direction + cardinal_direction * 0.1 ).angle() / TAU * DIR_4.size() ) )
	var new_dir = DIR_4[ direction_id ]
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	
	DirectionChanged.emit( new_dir )
	
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
	
	
	
	
	
	
