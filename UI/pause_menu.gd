extends CanvasLayer

func _on_continue_pressed():
	GameManager.continue_game()
	queue_free()

func _on_main_menu_pressed():
	GameManager.main_menu()
	queue_free()
