extends Node

var score

const SCREEN_HEIGHT = 720
const SCREEN_WIDTH = 900

const ASTEROIDS_GROUP = 'asteroids'
const BULLET_GROUP = 'bullet'
const SHIP_GROUP = 'ship'

signal score_changed

func _ready():
	randomize()
	score = 0

func add_to_score(value):
	if value >= 0:
		score += value
		emit_signal('score_changed')
