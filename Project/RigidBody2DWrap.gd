extends RigidBody2D

class_name RigidBody2DWrap

@onready var viewport_size = get_viewport().size
@onready var sprite_size = $Sprite2D.texture.get_size()

func _integrate_forces(state):
	wrap_to_viewport(state)
	pass

func wrap_to_viewport(state):
	if state.transform.origin.x < -sprite_size.x / 2:
		state.transform.origin.x = viewport_size.x + sprite_size.x / 2
	elif state.transform.origin.x > viewport_size.x + sprite_size.x / 2:
		state.transform.origin.x = -sprite_size.x / 2
	if state.transform.origin.y < -sprite_size.y / 2:
		state.transform.origin.y = viewport_size.y + sprite_size.y / 2
	elif state.transform.origin.y > viewport_size.y + sprite_size.y / 2:
		state.transform.origin.y = -sprite_size.y / 2
	pass
