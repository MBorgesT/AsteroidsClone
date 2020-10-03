extends 'res://scripts/asteroids/asteroid.gd'

func _ready():
	set_process(true)
	configure()
	
	score = (randi() % 2) + 1
	life = score
	
	add_to_group(game.ASTEROIDS_GROUP)
