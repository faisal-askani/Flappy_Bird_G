extends Label

class_name Score

var count_score = 0

func on_score():
	count_score += 1
	set_text(String.num(count_score))
	print("Score is ", count_score)

