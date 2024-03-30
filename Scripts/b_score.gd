extends Label

@onready var game_over_node = self.get_parent().get_parent().get_parent()

var score = 0
var lerped_score = 0.0
var target_score = 0.0
var lerp_speed = 3.0
var lerping = false
var is_called = false
var _anim_finished = false

func _ready():
	game_over_node.get_node("ScoreBoardAnim").animation_finished.connect(_check_anim)

func _process(delta):
	if game_over_node.visible and _anim_finished and !is_called:
		is_called = true
		start_lerping(Global.score+1)
#		print("gameover: ", game_over_node.visible," is_called: ", !is_called)
	if lerping:
		lerped_score = lerp(lerped_score, target_score, lerp_speed * delta)
		print("lerping")
		set_text(String.num(int(lerped_score)))
		if (target_score - lerped_score) < 0.1:
			lerping = false
#			print("Lerping is ", lerping)

func start_lerping(target):
	target_score = float(target)
	lerping = true

func _check_anim(anim_name : String):
	_anim_finished = true
	print(anim_name, " animation is finished")
