extends CharacterBody2D

@onready var animated = $AnimatedSprite2D
@onready var run_col = $RunHurtBox/RunCol
@onready var run_hurt_box = $RunHurtBox

const GRAVITY: int = 4200
const JUMP_SPEED: int = -1880

signal player_death

func _physics_process(delta: float):
	
	velocity.y += GRAVITY * delta
	if is_on_floor():
		run_col.disabled = false
		run_hurt_box.disable_mode = false
		if Input.is_action_pressed("jump"):
			velocity.y = JUMP_SPEED
		elif Input.is_action_pressed("crunch"):
			animated.play("blue_dino_crouch")
			run_col.disabled = true
			run_hurt_box.disable_mode = true
		else:
			animated.play("blue_dino_run")
	else:
		animated.play("blue_dino_jump")
		
	move_and_slide()

func _on_run_hurt_box_body_entered(body):
	if body.is_in_group("Obstacle"):
		print("morreu")
		player_death.emit()

func _on_crouch_hurt_box_body_entered(body):
	if body.is_in_group("Obstacle"):
		print("morreu")
		player_death.emit()
