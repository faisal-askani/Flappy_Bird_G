extends Node2D

@export var ground_speed = -150

@onready var ground_1 = $Ground1
@onready var ground_2 = $Ground2

var is_stop = false


func _ready():
	ground_1.connect("bird_crashed", _stop)
	ground_2.connect("bird_crashed", _stop)


func _process(delta):
	if !is_stop:
		_move_ground(delta)


func _move_ground(delta):
	if ground_1.position.x <= -312:
		ground_1.position.x = 312
	if ground_2.position.x <= -312:
		ground_2.position.x = 312
	ground_1.position.x += ground_speed * delta
	ground_2.position.x += ground_speed * delta


func _stop():
	is_stop = true
	print("Stop the ground movement")
