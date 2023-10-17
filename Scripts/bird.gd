extends RigidBody2D

class_name Bird

@export var falling_rotation_speed = 5
@export var rising_rotation_speed = 25

const JUMP_FORCE = -300.0

func _process(delta):
	if Input.is_action_just_pressed("jump"):
		_jump()
	
	_bird_rotation()
	move_and_collide(linear_velocity * delta)


func _jump():
	set_linear_velocity(Vector2(0.0, JUMP_FORCE))


func _bird_rotation():
		#Falling if velocity is greater else going upward
	if linear_velocity.y > 0 and rad_to_deg(rotation) < 90:
		rotation += falling_rotation_speed * deg_to_rad(1)
	elif linear_velocity.y < 0 and rad_to_deg(rotation) > -30:
		rotation -= rising_rotation_speed * deg_to_rad(1)
