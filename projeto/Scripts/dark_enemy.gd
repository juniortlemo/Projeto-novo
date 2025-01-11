extends CharacterBody2D
@onready var point_light_2d = $"../PointLight2D"
@onready var dark_enemy= $"."
var SPEED= 100
var moveDarkEnemy

func _physics_process(delta):
	var darkEnemyPos =dark_enemy.global_position
	var point_light_2dPos = point_light_2d.global_position
	
	if point_light_2d.enabled == true:
		var direction = (darkEnemyPos - point_light_2dPos).normalized()
		moveDarkEnemy= direction * SPEED * delta
		global_position -= moveDarkEnemy
	if darkEnemyPos.distance_to(point_light_2dPos) <= 10:
		point_light_2d.enabled = false
