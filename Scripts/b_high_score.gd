extends Label

@onready var game_over_node = self.get_parent().get_parent().get_parent()

@onready var previous_high_score = Global.save_data_g.high_score
var lerped_score = 0.0
var target_score = 0.0
var lerping = false
var is_called = false
var lerp_speed = 3.0

func _process(delta):
	if game_over_node.visible and !is_called:
		is_called = true
		if Global.score > previous_high_score:
			start_lerping(Global.save_data_g.high_score+1)
		else:
			set_text(String.num(Global.save_data_g.high_score))
		print("gameover: ", game_over_node.visible," is_called: ", !is_called)
	if lerping:
		lerped_score = lerp(lerped_score, target_score, lerp_speed * delta)
		print("lerping")
		text = str(int(lerped_score))
		if (target_score - lerped_score) < 0.1:
			lerping = false
			print("Lerping is ", lerping)

func start_lerping(target):
	target_score = float(target)
	lerping = true
