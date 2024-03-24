extends StaticBody2D

class_name Ground

signal bird_crashed


func _on_body_entered(body):
	if body.name == "Bird":
		print(body.name, " hit the ground")
		bird_crashed.emit()
		(body as Bird).stop()
