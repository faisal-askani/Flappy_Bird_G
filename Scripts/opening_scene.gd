extends Node2D


const GROUND_SPEED = -350
var children_nodes

func _ready():
	children_nodes = get_children().filter(func (child): return child is StaticBody2D)

func _process(delta):
	_move_ground(delta)

func _move_ground(delta):
	for ground in children_nodes:
		if ground.position.x <= -1440:
			ground.position.x = 1440
		ground.position.x += GROUND_SPEED * delta
