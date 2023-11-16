extends Control

@export var score_label : Label
@export var level_label : Label
@export var lives_label : Label

@export var game_over_panel : Panel

func _on_main_score_changed( score ):
	score_label.text = "Score: %d" % score


func _on_main_level_changed( level ):
	level_label.text = "Level: %d" % level


func _on_main_lives_changed( lives ):
	lives_label.text = "Lives: %d" % lives


func _on_main_game_over():
	game_over_panel.show()


func _on_restart_button_pressed():
	get_parent().restart_game()
	game_over_panel.hide()


func _on_exit_button_pressed():
	get_tree().quit()

