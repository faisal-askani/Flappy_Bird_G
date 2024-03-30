extends TextureRect

@onready var _score = $"../../../../ScoreLabel" as Score

func _ready():
	_score.connect("new_high_score", _show_new_high_score_label)

func _show_new_high_score_label():
	show()
