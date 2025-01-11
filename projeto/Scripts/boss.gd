extends CharacterBody2D

const SPEED = 100
const JUMP_VELOCITY = -400.0

var moveBoss
var minDistance = 40
var canJump
var canAttack

@onready var anim_tree_boss = $AnimTreeBoss
@onready var state_machine = anim_tree_boss["parameters/playback"]
@onready var Boss = $"."
@onready var player = $"../Player"

func _physics_process(delta):
	
	var BossPos = Boss.global_position
	var playerPos = player.global_position
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if playerPos.distance_to(BossPos)< 200 and playerPos.distance_to(BossPos)>40:
		anim_tree_boss.set("parameters/conditions/seePlayer",true)
	else:
		anim_tree_boss.set("parameters/conditions/seePlayer",false)
		
	if playerPos.distance_to(BossPos)<= 40:
		anim_tree_boss.set("parameters/conditions/hitPlayer",true)
	else:
		anim_tree_boss.set("parameters/conditions/hitPlayer",false)
	
	
	match state_machine.get_current_node():
		"Run":
			if BossPos.distance_to(playerPos) > minDistance and BossPos.distance_to(playerPos)<200:
				var direction = (playerPos - BossPos).normalized()
				moveBoss= direction * SPEED * delta
				global_position += moveBoss
			if BossPos < playerPos:
				$AnimBoss.scale.x = 1
			else:
				$AnimBoss.scale.x = -1
		"Jump":
			if is_on_floor():
				velocity.y = JUMP_VELOCITY

		"Attack":
			pass
	move_and_slide()
	
