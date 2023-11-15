extends RigidBody2DWrap

signal has_died

var rotation_speed = TAU
var thrust_force = 400
var fire_cooldown = 0.25
var fire_cooldown_remaining = 0
const bullet_scene = preload( "res://bullet.tscn" )

func _ready():
	pass


func _physics_process(delta):
	angular_velocity = 0

	# Rotate Colckwise
	if Input.is_action_pressed( "rotate_cw" ):
		angular_velocity = rotation_speed
	
	# Rotate Counterclockwise
	if Input.is_action_pressed( "rotate_ccw" ):
		angular_velocity = -rotation_speed

	# Thrust forward
	if Input.is_action_pressed( "thrust_forward" ):
		apply_force( Vector2.UP.rotated( rotation ) * thrust_force )
	
	# Fire bullets
	fire_cooldown_remaining -= delta
	if fire_cooldown_remaining <= 0 && Input.is_action_pressed( "fire" ):
		fire_cooldown_remaining = fire_cooldown
		shoot_bullet()

func shoot_bullet():

	# Create an array of bullet spawn points
	var bullet_spawns = [
		$Gun/BulletSpawn1,
		$Gun2/BulletSpawn2,
	]

	# Loop through the array of bullet spawn points
	for bullet_spawn in bullet_spawns:

		# Create a bullet
		var n = bullet_scene.instantiate()
		n.rotation = rotation
		n.position = bullet_spawn.global_position
		get_parent().add_child(n)

func _on_body_entered( body ):
	has_died.emit()

