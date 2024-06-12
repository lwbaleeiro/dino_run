extends CanvasLayer

@onready var label_score = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/LabelScore

func _on_play_again_pressed():
	SceneManager.start_game()
	visible = false

func set_score(score: String):
	label_score.text = str("Your score: ", score)

func _on_quit_game_pressed():
	GameManager.exit_game()
