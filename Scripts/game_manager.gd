extends Node

var MAIN_MENU = preload("res://UI/main_menu.tscn")
var PAUSE_MENU = preload("res://UI/pause_menu.tscn")

var player_name: String
var high_score_data: HighScoreData

func _ready():
	high_score_data = HighScoreData.load_data()
	
func setup_game():
	if get_tree().paused:
		continue_game()
		return
	SceneManager.setup_game()
	
func start_game():
	if get_tree().paused:
		continue_game()
		return
	
	SceneManager.start_game()
	
func exit_game():
	get_tree().quit()
	
func pause_game():
	get_tree().paused = true
	var pause_menu_screen = PAUSE_MENU.instantiate()
	get_tree().get_root().add_child(pause_menu_screen)

func continue_game():
	get_tree().paused = false

func main_menu():
	var main_menu_screen = MAIN_MENU.instantiate()
	get_tree().get_root().add_child(main_menu_screen)
