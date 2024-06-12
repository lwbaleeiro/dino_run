extends CanvasLayer

@onready var display_name = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/DisplayName

func _on_start_game_pressed():
	
	if display_name.text != "":
		GameManager.player_name = display_name.text
	
	GameManager.start_game()
	queue_free()
