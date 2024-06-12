extends Node

@onready var die_screen = $DieScreen

# Preload obstacles
var stump = preload("res://Objects/stump.tscn")
var rock = preload("res://Objects/rock.tscn")
var bird = preload("res://Objects/bird.tscn")
var barrel = preload("res://Objects/barrel.tscn")

var obstacle_types := [stump, rock, barrel]
var obstacles : Array
var bird_heights := [200, 390]
var last_obstacle

# Game Variables
const SCORE_MODIFIER: int = 10
const MAX_DIFFICULTY: int = 2
var score: int
var difficulty
var ground_height: int
var screen_size: Vector2i

# Dino
const DINO_START_POS := Vector2i(150, 485)
const CAM_START_POS := Vector2i(576, 324)
const START_SPEED: float = 10.0
const MAX_SPEED: int = 25
const SPEED_MODIFIER: int = 5000

var speed: float

@onready var game_screen = $GameScreen
@onready var count_down = $CountDown
@onready var dino = $Dino

func _ready():
	dino.player_death.connect(_on_dino_death)
	
	difficulty = 0
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	
	_best_score()
	_new_game()
	_delay_game()

func _pause_game():
	if Input.is_action_pressed("pause"):
		GameManager.pause_game()
		_delay_game()

func _delay_game():
	get_tree().paused = true
	for i in range(5, -1, -1):
		count_down.text = str(i)
		await get_tree().create_timer(1).timeout
	get_tree().paused = false

func _new_game():
	score = 0
	difficulty = 0
	last_obstacle = null
	obstacles = []
	
	$Dino.position = DINO_START_POS
	$Dino.velocity = Vector2i(0, 0)
	$Camera2D.position = CAM_START_POS
	$Ground.position = Vector2i(0, 0)
	get_tree().paused = false

func _on_dino_death():

	if int(game_screen.label_score.text) > int(game_screen.label_best_score.text):
		_save_high_score()
		
	get_tree().paused = true
	die_screen.set_score(str(game_screen.label_score.text))
	die_screen.visible = true

func _process(_delta):
	
	_pause_game()
	_generate_obstacles()
	
	speed = START_SPEED + score / SPEED_MODIFIER
	if speed > MAX_SPEED:
		speed = MAX_SPEED
		
	_adjust_difficulty()
	_score()
	
	$Dino.position.x += speed
	$Camera2D.position.x += speed
	
	if $Camera2D.position.x - $Ground.position.x > screen_size.x * 1.5:
		$Ground.position.x += screen_size.x
		
	for obs in obstacles:
		if obs.position.x < ($Camera2D.position.x - screen_size.x):
			_remove_obstacle(obs)

func _generate_obstacles():
	
	if obstacles.is_empty() or last_obstacle.position.x < score + randi_range(300, 500):
		var obs_type = obstacle_types[randi() % obstacle_types.size()]
		var max_obstacle = difficulty + 1
		var obs
		
		for i in range(randi() % max_obstacle + 1):
			obs = obs_type.instantiate()
			var obs_height = obs.get_node("Sprite2D").texture.get_height()
			var obs_scale = obs.get_node("Sprite2D").scale
			var obs_x: int = screen_size.x + score + 100 + (i * 100)
			var obs_y: int = screen_size.y - ground_height - (obs_height * obs_scale.y / 2) + 5
			
			last_obstacle = obs
			_add_obs(obs, obs_x, obs_y)
		
		if difficulty == MAX_DIFFICULTY:
			if (randi() % 2) == 0:
				obs = bird.instantiate()
				var obs_x: int = screen_size.x + score + 100
				var obs_y: int = bird_heights[randi() % bird_heights.size()]
				_add_obs(obs, obs_x, obs_y)

func _add_obs(obstacle, x, y):
		obstacle.position = Vector2i(x, y)
		add_child(obstacle)
		obstacles.append(obstacle)

func _remove_obstacle(obstacle):
	obstacle.queue_free()
	obstacles.erase(obstacle)

func _save_high_score():
	GameManager.high_score_data.high_score["name"] = GameManager.player_name
	GameManager.high_score_data.high_score["score"] = str(game_screen.label_score.text)
	GameManager.high_score_data.high_score["date"] = Time.get_datetime_string_from_system()
	
	GameManager.high_score_data.save()

func _score():
	score += speed
	game_screen.score_updated(score / SCORE_MODIFIER)
	
func _best_score():
	var data = GameManager.high_score_data.get_high_score()
	game_screen.best_score_updated(data.high_score["score"])

func _adjust_difficulty():
	difficulty = score / SPEED_MODIFIER
	if difficulty > MAX_DIFFICULTY:
		difficulty = MAX_DIFFICULTY
