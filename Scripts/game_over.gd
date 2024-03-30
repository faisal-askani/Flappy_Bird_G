extends Control

class_name GameOver

signal game_over

@onready var _title_anim = $GameOverTitleAnim
@onready var _score_board_anim = $ScoreBoardAnim
@onready var _hit_flash_anim = $HitFlashAnim
@onready var _score_label = $"../ScoreLabel"
var _is_hit = false

func _ready():
	print("Game over is called")
	self.get_parent().get_parent().get_node("Bird").connect("bird_hit_pipe", _on_game_over)
	var children_nodes = get_tree().get_root().get_node("Main").get_children()
	for ground in children_nodes.filter(func (child): return child is Ground):
		ground.connect("bird_crashed", _on_game_over)

func _on_game_over():
	if !_is_hit:
		_is_hit = true
		_score_label.hide()
		show()
		_hit_flash_anim.play("hit_flash")
		await _hit_flash_anim.animation_finished
		_title_anim.play("gameover_title_popup")
		await _title_anim.animation_finished
		_score_board_anim.play("score_board_popup")
		game_over.emit()
