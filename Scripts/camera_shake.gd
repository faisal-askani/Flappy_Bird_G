extends Node

@onready var camera = get_parent()
@onready var _game_over = 	get_tree().get_root().get_node("Main").get_node("CanvasLayer").get_children()

var time = 0
var duration = 0.18
var magnitude = 10.0
var shake_it = false

func _ready():
	for gameover in _game_over.filter(func (child): return child is GameOver):
		print("This is camera: ", gameover)
		gameover.connect("sig_shake", _on_game_over)

func _process(delta):
	if shake_it:
		shake(delta)

func shake(d):
	shake_it = false
	var initial_offset = camera.get_offset()
	while time < duration:
		time += d
		var offset = Vector2()
		offset.x = randf_range(-magnitude, magnitude)
		offset.y = randf_range(-magnitude, magnitude)
		camera.set_offset(initial_offset + offset)
		await get_tree().process_frame #wait until the frame is done
	time = 0
	camera.set_offset(initial_offset)

func _on_game_over():
	shake_it = true
