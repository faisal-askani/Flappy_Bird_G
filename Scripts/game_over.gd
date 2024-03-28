extends MarginContainer

class_name GameOver

func _ready():
	self.get_parent().get_parent().get_node("Bird").connect("bird_hit_pipe", _on_game_over)
	var children_nodes = get_tree().get_root().get_node("Main").get_children()
	for ground in children_nodes.filter(func (child): return child is Ground):
		ground.connect("bird_crashed", _on_game_over)

func _on_game_over():
	show()

