extends Node

var small_asteroids = []
var medium_asteroids = []

const PATH_SMALL = 'res://scenes/asteroids/small/'
const PATH_MEDIUM = 'res://scenes/asteroids/medium/'

func _ready():
	load_pre_asteroids()
	randomize()
	
func get_asteroid_path():
	if randi() % 2 == 0:
		return small_asteroids[randi() % small_asteroids.size()]
	else:
		return medium_asteroids[randi() % medium_asteroids.size()]
	
func load_pre_asteroids():
	# small
	var dir = Directory.new()
	dir.change_dir(PATH_SMALL)
	dir.list_dir_begin()
	
	var file = dir.get_next()
	while file != '':
		var asteroid = load(PATH_SMALL + file)
		if asteroid and asteroid is PackedScene:
			small_asteroids.append(PATH_SMALL + file)
		file = dir.get_next()
		
	# medium
	dir = Directory.new()
	dir.change_dir(PATH_MEDIUM)
	dir.list_dir_begin()
	
	file = dir.get_next()
	while file != '':
		var asteroid = load(PATH_MEDIUM + file)
		if asteroid and asteroid is PackedScene:
			medium_asteroids.append(PATH_MEDIUM + file)
		file = dir.get_next()

