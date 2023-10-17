extends Node2D

@export var ground_speed = -150

@onready var ground_1 = $Ground1
@onready var ground_2 = $Ground2


func _process(delta):
	_move_ground(delta)


func _move_ground(delta):
	if ground_1.position.x <= -312:
		ground_1.position.x = 312
	if ground_2.position.x <= -312:
		ground_2.position.x = 312
	ground_1.position.x += ground_speed * delta
	ground_2.position.x += ground_speed * delta
