extends CharacterBody2D

@onready var stamina_bar = $Camera2D/StaminaBar
@onready var timer = $Timer

var stamina = 100
var max_stamina = 100
var canRegen= false
var SPEED = 300.0
const JUMP_VELOCITY = -400.0
	
func _physics_process(delta):
	stamina_bar.value = stamina
	if canRegen and stamina<50:
		stamina+= 10*delta
	if canRegen and stamina>=50:
		stamina+= 5*delta
		
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("Shift") and stamina >=0 and velocity.x!=0:
		canRegen= false
		stamina-= 30*delta
		SPEED= 500
	else:
		SPEED= 300
	if Input.is_action_pressed("Shift") and stamina<100:
		timer.start()
		
	if Input.is_action_pressed("ctrl"):
		SPEED = 100
		
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
		
func _on_timer_timeout():
	canRegen= true
