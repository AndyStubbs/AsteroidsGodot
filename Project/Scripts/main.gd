extends Node

signal SCORE_CHANGED
signal LEVEL_CHANGED
signal LIVES_CHANGED
signal GAME_OVER

var score:
	get:
		return score
	set( value ):
		score = value
		SCORE_CHANGED.emit( score )

var level:
	get:
		return level
	set( value ):
		level = value
		LEVEL_CHANGED.emit( level )

var lives:
	get:
		return lives
	set( value ):
		lives = value
		LIVES_CHANGED.emit( lives )

var num_asteroids = 3
var player_scene = preload( "res://Scenes/player.tscn" )
var asteroid_big_scene = preload( "res://Scenes/asteroid_big.tscn" )
var player_node : Node2D = null

@onready var viewport_size = get_viewport().size

@export var asteroid_container : Node

func _on_player_death():
	player_node.queue_free()
	
	if lives <= 0:
		game_over()
	else:
		call_deferred( "spawn_player" )
		lives -= 1

func game_over():
	GAME_OVER.emit()


func _ready():
	start_new_game()


func restart_game():
	clean_up_game()
	start_new_game()


func clean_up_game():
	pass


func start_new_game():
	lives = 3
	level = 0
	score = 0
	setup_new_level( num_asteroids )
	spawn_player()


func _process(delta):
	pass


func setup_new_level( asteroids_count ):
	print( level )
	level += 1
	
	for i in asteroids_count:
		spawn_asteroid()
	


func spawn_player():
	player_node = player_scene.instantiate()
	player_node.position = viewport_size / 2
	player_node.has_died.connect( _on_player_death )
	add_child( player_node )


func spawn_asteroid():
	var n = asteroid_big_scene.instantiate()
	
	n.position.x = randf_range( 0, viewport_size.x )
	n.position.y = randf_range( 0, viewport_size.y )
	
	asteroid_container.add_child( n )
	pass


func add_to_score( n ):
	score += n

