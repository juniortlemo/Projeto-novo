extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta):

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$CollisionShape2D.scale.x= direction
		$Anim.scale.x= direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	_set_state()
func _set_state():
	var state = "idle"
	
	if !is_on_floor():
		state= "Jump"
	elif velocity.x !=0:
		state="Run"
	else:
		state="Idle"
	if $AnimationPlayer.name !=state:
		$AnimationPlayer.play(state)
