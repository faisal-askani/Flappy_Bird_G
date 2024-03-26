extends Control

@onready var anim = $AnimationPlayer
@onready var bird = $"../../Bird" as Bird

func _ready():
	bird.bird_jumped_sig.connect(_fade_anim)

func _fade_anim():
	anim.play("FadeOut")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "FadeOut":
		print("Tap FadeOut Animation")
		queue_free()
