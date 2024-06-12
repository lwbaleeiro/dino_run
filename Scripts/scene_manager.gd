extends Node

var scenes: Dictionary = {"main": "res://Levels/main.tscn", "setup": "res://UI/game_setup.tscn"}

func setup_game():
	await get_tree().create_timer(0.1).timeout
	transition_to_scene("setup")

func start_game():
	await get_tree().create_timer(0.5).timeout
	transition_to_scene("main")

func transition_to_scene(scene: String):
	var scene_path: String = scenes.get(scene)
	
	if scene_path != null:
		get_tree().change_scene_to_file(scene_path)
