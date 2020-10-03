extends Node

var chance

const START_CHANCE = 10
const STEP = 1

func _ready():
	set_process(true)
	
	chance = START_CHANCE
	
	pass 
	
func _process(delta):
	pass
	
func _on_spawn_timer_timeout():
	if randi() % 100 < chance:
		var loaded_asteroid = load(resources.get_asteroid_path())
		var asteroid = loaded_asteroid.instance()
		
		get_owner().add_child(asteroid)

func _on_difficulty_increaser_timeout():
	chance += STEP
