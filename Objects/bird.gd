extends StaticBody2D

func _process(_delta):
	position.x -= get_parent().speed / 2
