extends Label

class_name Score

signal new_high_score

@onready var _bird = $"../../Bird"
@onready var _game_over = $"../GameOver" as GameOver
var is_hit = false

func _ready():
	_game_over.connect("game_over", _check_high_score)
	Global.score = 0
	print("Onready: Score is:", Global.score, " High score is:", Global.save_data_g.high_score)

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
			new_high_score.emit()
		print("When hit: Score is:", Global.score, " High score is:", Global.save_data_g.high_score)
