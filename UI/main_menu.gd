extends CanvasLayer

func _on_play_pressed():
	GameManager.setup_game()
	queue_free()

func _on_quit_pressed():
	GameManager.exit_game()
