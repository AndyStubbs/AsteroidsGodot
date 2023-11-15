extends RigidBody2DWrap

signal was_shot

const STARTING_FORCE = 100

@export var debris_scene : PackedScene
@export var debris_amount = 3


func _ready():
	apply_impulse(
		Util.RandomUnitVector2() * randf_range( STARTING_FORCE / 2.0, STARTING_FORCE * 2.0 )
	)


func _on_was_shot():
	if debris_scene:
		for i in debris_amount:
			var n = debris_scene.instantiate()
			n.global_position = global_position
			get_parent().add_child(n)

	queue_free()
