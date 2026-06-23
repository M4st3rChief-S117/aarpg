class_name Plant extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitBox.Damaged.connect( TakeDamage )
	pass # Replace with function body.

# When adding _ it tells Godot that the value is optional
func TakeDamage( _damage : int ) -> void:
	# Get rid of the plant
	queue_free()
	pass
