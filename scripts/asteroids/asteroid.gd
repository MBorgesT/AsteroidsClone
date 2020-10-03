extends Area2D

var life
var score

var direction
var velocity
var turn_rate

const MAX_VEL = 220
const MIN_VEL = 50

const MAX_TRN = 180
const MIN_TRN = 0

func _ready():
	randomize()
	
	set_process(true)
	configure()
	
	score = (randi() % 3) + 1
	life = score
	
	add_to_group(game.ASTEROIDS_GROUP)
	
func _process(delta):
	# position
	set_position(get_position() + direction * velocity * delta)
	
	# check for deletion
	var pos = get_position()
	if pos.x < -150 or pos.x > game.SCREEN_WIDTH + 150 or pos.y < -150 or pos.y > game.SCREEN_HEIGHT + 150:
		delete_from_memory()
		
	# rotate
	rotate(deg2rad(turn_rate) * delta)
	
func configure():
	# direction
	
	# in which side of the screen the meteor will spawn
	# counter clockwise, starting on top
	var op = randi() % 4
	var pos
	var rand_point
	
	if op == 0:
		pos = Vector2((randi() % (100 + game.SCREEN_WIDTH)) - 100, -100)
		set_position(pos)
		
		rand_point = Vector2(randi() % game.SCREEN_WIDTH, game.SCREEN_HEIGHT)
	elif op == 1:
		pos = Vector2(-100, (randi() % (100 + game.SCREEN_HEIGHT)) - 100)
		set_position(pos)
		
		rand_point = Vector2(game.SCREEN_WIDTH, randi() % game.SCREEN_HEIGHT)
	elif op == 2:
		pos = Vector2((randi() % (100 + game.SCREEN_WIDTH)) - 100, game.SCREEN_HEIGHT + 100)
		set_position(pos)
		
		rand_point = Vector2(randi() % game.SCREEN_WIDTH, 0)
	elif op == 3:
		pos = Vector2(game.SCREEN_WIDTH + 100, (randi() % (100 + game.SCREEN_HEIGHT)) - 100)
		set_position(pos)
		
		rand_point = Vector2(0, randi() % game.SCREEN_HEIGHT)
	
	direction = (rand_point - pos).normalized()
	
	# velocity
	velocity = (randi() % MAX_VEL) + MIN_VEL
	
	# turn_rate
	turn_rate = (randi() % MAX_TRN) + MIN_TRN

func hit():
	life -= 1
	if life <= 0:
		destroy()
		
func delete_from_memory():
	set_process(false)
	remove_from_group(game.ASTEROIDS_GROUP)
	queue_free()

func destroy():
	game.add_to_score(score)
	delete_from_memory()
