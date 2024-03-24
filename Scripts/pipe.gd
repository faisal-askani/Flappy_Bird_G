extends Area2D

class_name Pipe

signal pipe_hit_sig

var is_start = true


func _process(delta):
	if is_start:
		position.x += -350 * delta
		_destroy_pipe()


func _on_body_entered(body):
	if body.name == "Bird":
		pipe_hit_sig.emit()
		(body as Bird).pipe_hit()
		print("Bird Collide Pipe")


func _destroy_pipe():
	if position.x < -720:
		queue_free()
