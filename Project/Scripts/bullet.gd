extends Area2D

const SPEED = 400
var lifespan = 5.0
var type = "bullet"

func _physics_process( delta ):
	lifespan -= delta
	if lifespan <= 0:
		queue_free()
		return
	
	translate( Vector2.UP.rotated( rotation ) * SPEED * delta )


func _on_body_entered( body ):
	if body.was_shot:
		body.was_shot.emit()
		queue_free()
