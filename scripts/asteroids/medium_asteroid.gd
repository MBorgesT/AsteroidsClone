extends 'res://scripts/asteroids/asteroid.gd'

func _ready():
	set_process(true)
	configure()
	
	score = (randi() % 4) + 2
	life = score
	
	add_to_group(game.ASTEROIDS_GROUP)
