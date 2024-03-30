extends RigidBody2D

class_name Bird

signal bird_jumped_sig
signal bird_hit_pipe

const JUMP_FORCE = -750.0

@export var falling_rotation_speed = 5
@export var rising_rotation_speed = 20

@onready var anim = $AnimationPlayer
@onready var _wing = sound_player.get_node("WingAudioStream")

var is_start = true
var start_rotation = false
var bird_jumped = false

func _ready():
	anim.play("Idle")


func _process(delta):
	if Input.is_action_just_pressed("jump") and is_start:
		if !bird_jumped:
			anim.play("Flap")
			bird_jumped_sig.emit()
			bird_jumped = true
		start_rotation = true
		_jump()
	
	if start_rotation:
		_bird_rotation()
	move_and_collide(linear_velocity * delta)


func _jump():
	_wing.play()
	set_linear_velocity(Vector2(0.0, JUMP_FORCE))


func _bird_rotation():
	#Falling if velocity is greater else going upward
	if linear_velocity.y > 0 and rad_to_deg(rotation) < 90:
		rotation += falling_rotation_speed * deg_to_rad(1.3)
	elif linear_velocity.y < 0 and rad_to_deg(rotation) > -30:
		rotation = deg_to_rad(-30)


func pipe_hit():
	print("Stop bird functioning(pipe hit)")
	falling_rotation_speed = 15
	anim.pause()
	if is_start: set_linear_velocity(Vector2(0.0, 0.0))
	is_start = false
	bird_hit_pipe.emit()


func stop():
	print("Stop bird functioning(ground hit)")
	is_start = false
	start_rotation = false
	anim.pause()
	set_deferred("freeze", true)
	set_linear_velocity(Vector2(0.0, 0.0))
