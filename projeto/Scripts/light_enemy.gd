extends CharacterBody2D


@onready var player = $"../Player"
@onready var point_light_2d = $"../PointLight2D"
@onready var light_enemy= $"."
var SPEED= 100
var movelightEnemy

func _physics_process(delta):
	var lightEnemyPos =light_enemy.global_position
	var playerPos = player.global_position
	
	if point_light_2d.enabled == false:
		var direction = (lightEnemyPos - playerPos).normalized()
		movelightEnemy= direction * SPEED * delta
		global_position -= movelightEnemy
		
		
