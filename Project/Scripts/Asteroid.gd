class_name Asteroid
extends "res://Scripts/RigidBody2DWrap.gd"

signal was_shot

const STARTING_FORCE = 100
const Util := preload( "res://Scripts/Util.gd" )
@export var debris_scene : PackedScene
@export var debris_amount = 3


func _ready():
	apply_impulse(
		Util.RandomUnitVector2() * randf_range( STARTING_FORCE / 2.0, STARTING_FORCE * 2.0 )
	)


func _on_was_shot():
	call_deferred( "destory_asteroid" )


func destory_asteroid():
	if debris_scene:
		for i in debris_amount:
			var n = debris_scene.instantiate()
			n.global_position = global_position
			get_parent().get_parent().spawn_asteroid( n )
	queue_free()


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print( "Shape Entered" )
