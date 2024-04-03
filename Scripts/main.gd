extends Node2D

@export var ground_speed = -350

@onready var bird = $Bird as Bird
@onready var score_label = $CanvasLayer/ScoreLabel as Score
@onready var timer = Timer.new()

var pipe_scene = preload("res://Scenes/pipe.tscn")
var pipe_scene_scr = preload("res://Scenes/pipe.tscn")
var pipe_head_scene = preload("res://Scenes/pipe_head.tscn")

var gap_size = 5
var total_height = 20
var min_value = 55  # Representing 5.5 when divided by 10
var max_value = 145  # Representing 14.5 when divided by 10
var is_stop = false


func _ready():
	for ground in get_children().filter(func (child): return child is Ground):
		ground.connect("bird_crashed", _stop)
	bird.bird_jumped_sig.connect(_start)
	
	timer.wait_time = 1.4
	timer.connect("timeout", _create_pipes)
	add_child(timer)


func _process(delta):
	if !is_stop:
		_move_ground(delta)


func _move_ground(delta):
	for ground in get_children().filter(func (child): return child is Ground):
		if ground.position.x <= -1440:
			ground.position.x = 1440
		ground.position.x += ground_speed * delta


func _pipe_calculation():
	var height = (float(randi() % ((max_value - min_value) / 5 + 1) * 5 + min_value)) / 10.0
	return height


func _create_pipes():
	var top_pipe_out_screen = pipe_scene_scr.instantiate()
	var top_pipe = pipe_scene.instantiate()
	var bottom_pipe = pipe_scene.instantiate()
	var pipe_head_bottom = pipe_head_scene.instantiate()
	var pipe_head_top = pipe_head_scene.instantiate()
	
	top_pipe.score_sig.connect(score_label.on_score)
	top_pipe_out_screen.connect("pipe_hit_sig", _stop)
	top_pipe.connect("pipe_hit_sig", _stop)
	bottom_pipe.connect("pipe_hit_sig", _stop)
	
	bottom_pipe.position = Vector2(512, 640)
	top_pipe.rotation = deg_to_rad(180)
	top_pipe.position = Vector2(512, -640) 
	top_pipe.get_node("Sprite2D").flip_h = true
	top_pipe_out_screen.position = Vector2(512,-640)
	
	var height = _pipe_calculation()
	bottom_pipe.scale.y = height - gap_size * 0.5
	top_pipe.scale.y = total_height - height - gap_size * 0.5
	top_pipe_out_screen.scale.y = 20
	
	pipe_head_bottom.position = Vector2(512, 640 - 64 * bottom_pipe.scale.y)
	pipe_head_top.position = Vector2(512, -640 + 64 * top_pipe.scale.y)
	pipe_head_top.rotation = deg_to_rad(180)
	pipe_head_top.get_node("Sprite2D").flip_h = true
	
	add_child(top_pipe_out_screen)
	add_child(bottom_pipe)
	add_child(top_pipe)
	add_child(pipe_head_bottom)
	add_child(pipe_head_top)


func _stop():
	is_stop = true
	timer.stop()
	for pipe in get_children().filter(func (child): return child is Pipe):
		(pipe as Pipe).is_start = false
	print("Stop the Scene")


func _start():
	timer.start()
	print("Start creating pipes")
