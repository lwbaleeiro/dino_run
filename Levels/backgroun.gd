extends Sprite2D

var velocity: float = 5.5
var background_width: float = 0

func _ready():
	background_width = texture.get_size().x * scale.x

func _process(_delta: float) -> void:
	position.x += velocity
	_attempt_reposition()

func _attempt_reposition() -> void:

	if position.x < -background_width:
		position.x += 2 * background_width
