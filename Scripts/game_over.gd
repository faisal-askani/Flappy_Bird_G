extends Control

class_name GameOver

signal game_over
signal sig_shake

@onready var _title_anim = $GameOverTitleAnim
@onready var _score_board_anim = $ScoreBoardAnim
@onready var _hit_flash_anim = $HitFlashAnim
@onready var _score_label = $"../ScoreLabel"
@onready var _V_Box_Container = $VBoxContainer
@onready var _hurt = sound_player.get_node("HurtAudioStream")
@onready var _die = sound_player.get_node("DieAudioStream")
var _is_hit = false

func _ready():
	print("Game over is called")
	_V_Box_Container.hide()
	self.get_parent().get_parent().get_node("Bird").connect("bird_hit_pipe", _on_game_over)
	var children_nodes = get_tree().get_root().get_node("Main").get_children()
	for ground in children_nodes.filter(func (child): return child is Ground):
		ground.connect("bird_crashed", _on_game_over)

func _on_game_over():
	if !_is_hit:
		_is_hit = true
		sig_shake.emit()
		_score_label.hide()
		show()
		_hit_flash_anim.play("hit_flash")
		_hurt.play()
		await _hit_flash_anim.animation_finished
		_die.play()
		_title_anim.play("gameover_title_popup")
		await _title_anim.animation_finished
		_V_Box_Container.show()
		_score_board_anim.play("score_board_popup")
		game_over.emit()
