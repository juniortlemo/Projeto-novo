extends CharacterBody2D


const SPEED = 8000.0
const JUMP_VELOCITY = -400.0
var direction = -1

func _physics_process(delta):
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if $Wall.is_colliding():
		direction *=-1
		$Wall.scale.x *=-1

	if direction== 1:
		velocity.x= SPEED*delta
	else:
		velocity.x= -SPEED*delta
	move_and_slide()
	_set_state_anim()

func _set_state_anim():
	var state = "Idle"
	
	if !is_on_floor():
		state= "Jump"
	elif velocity.x !=0:
		if direction==1:
			$Wall.rotation_degrees= -90
		else:
			$Wall.rotation_degrees= 90
		$AnimBoss.scale.x= direction
		state="Run"
	else:
		state="Idle"
	if $AnimationBoss.name !=state:
		$AnimationBoss.play(state)
