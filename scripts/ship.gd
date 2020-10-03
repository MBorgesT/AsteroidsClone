extends Area2D

var vel
var time

var direction

var cooldown
var pre_bullet = preload('res://scenes/bullet.tscn')

var destroyed

const power = 1.4
const max_vel = 650
const max_time = 2.2

const turn_rate = 220

const max_cooldown = .2

func _ready():
	set_process(true)
	
	vel = 0
	time = 0
	
	direction = Vector2(0, -1)
	
	cooldown = 0
	
	destroyed = false
	
	add_to_group(game.SHIP_GROUP)
	
func _process(delta):
	# velocity
	if Input.is_action_pressed('up'):
		time = min(max_time, time + delta)
		get_node('sprite').get_node('fuel_burn').set_emitting(true)
	else:
		time = max(0, time - delta)
		get_node('sprite').get_node('fuel_burn').set_emitting(false)
	calculate_vel()
	
	# direction
	if Input.is_action_pressed('left') and not Input.is_action_pressed('right'):
		rotate(-delta)
	elif Input.is_action_pressed('right') and not Input.is_action_pressed('left'):
		rotate(delta)
		
	# movimentation
	set_position(get_position() + direction * vel * delta)
	
	# pew pew
	if Input.is_action_pressed('shoot'):
		if cooldown <= 0:
			create_bullet()
			cooldown = max_cooldown
	
	cooldown -= delta
	
func calculate_vel():
	var normalized_time = time / max_time
	vel = pow(normalized_time, power) * max_vel
	
func create_bullet():
	var bullet = pre_bullet.instance()
	var gun = get_node('sprite').get_node('gun')
	bullet.add_to_group(game.BULLET_GROUP)
	bullet.set_global_position(gun.get_global_position())
	bullet.set_direction(direction)
	get_node('../').add_child(bullet)
	
func rotate(delta):
	var angle = delta * turn_rate
	
	direction = Vector2(
			direction.x * cos(deg2rad(angle)) - direction.y * sin(deg2rad(angle)),
			direction.x * sin(deg2rad(angle)) + direction.y * cos(deg2rad(angle))
		)
		
	get_node('sprite').rotate(deg2rad(angle))
	get_node('collision').rotate(deg2rad(angle))
	
func destroy():
	destroyed = true
	get_node('destruction').play('explosion')
	set_process(false)
	
func continue_destruction():
	get_tree().change_scene('res://scenes/game_over.tscn')
	queue_free()

func _on_ship_area_entered(area):
	if area.is_in_group(game.ASTEROIDS_GROUP) and not destroyed:
		destroy()
