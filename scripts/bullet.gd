extends Area2D

var direction setget set_direction

const vel = 800

func _ready():
	set_process(true)
	get_node('sound_fx').play()
	
func _process(delta):
	var pos = get_position()
	set_position(pos + direction * vel * delta)
	
	if pos.x < -100 or pos.x > game.SCREEN_WIDTH + 100 or pos.y < -100 or pos.y > game.SCREEN_HEIGHT + 100:
		queue_free()
	
func set_direction(value):
	direction = value
	rotate(value.angle() + deg2rad(90))

func _on_bullet_area_entered(area):
	if area.is_in_group(game.ASTEROIDS_GROUP) and is_in_group(game.BULLET_GROUP):
		if area.has_method('hit'):
			area.hit()
			self.destroy()
		
func destroy():
	get_node('sprite').hide()
	remove_from_group(game.BULLET_GROUP)
	get_node('destroy_timer').start()

func _on_destroy_timer_timeout():
	set_process(false)
	queue_free()
