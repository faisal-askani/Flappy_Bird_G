extends StaticBody2D

signal bird_crashed


func _on_body_entered(body):
	if body.name == "Bird":
		print(body.name, " has been enter")
		bird_crashed.emit()
		(body as Bird).stop()
