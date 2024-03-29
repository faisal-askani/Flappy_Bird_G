extends Label

class_name Score

@onready var _bird = $"../../Bird"
@onready var _game_over = $"../GameOver" as GameOver
var is_hit = false

func _ready():
#	_bird.connect("bird_hit_pipe", _check_high_score)
#	var children_nodes = get_tree().get_root().get_node("Main").get_children()
#	for ground in children_nodes.filter(func (child): return child is Ground):
#		ground.connect("bird_crashed", _check_high_score)
	_game_over.connect("game_over", _check_high_score)
	Global.score = 0
	print("Onready: Score is ", Global.score, " High score is ", Global.save_data_g.high_score)

func on_score():
	Global.score += 1
	set_text(String.num(Global.score))
	print("Score is ", Global.score)

func _check_high_score():
	if !is_hit:
		is_hit = true
		if Global.score > Global.save_data_g.high_score:
			Global.save_data_g.high_score = Global.score
			Global.save_data_g.save()
		print("When hit: Score is ", Global.score, " High score is ", Global.save_data_g.high_score)
