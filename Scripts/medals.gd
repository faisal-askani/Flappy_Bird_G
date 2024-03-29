extends TextureRect

@onready var _game_over = self.get_parent().get_parent().get_parent()
var is_hit = false
var _bronze = 10
var _silver = 20
var _gold = 30

func _ready():
	print("medal is called")
	_game_over.connect("game_over", _medal)

func _medal():
	if !is_hit:
		is_hit = true
		if Global.score >= _bronze and Global.score < _silver:
			texture = load("res://Assets/sprites/medal_bronze.png")
		elif Global.score >= _silver and Global.score < _gold:
			texture = load("res://Assets/sprites/medal_silver.png")
		elif Global.score >= _gold:
			texture = load("res://Assets/sprites/medal_gold.png")
