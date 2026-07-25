extends CharacterBody2D

var dir
var spd = 100
var dmg = 1

func _physics_process(delta: float) -> void:
	velocity = dir * spd
	$GPUParticles2D.process_material.gravity = Vector3(-dir.x, -dir.y, 0)
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == 'knight':
		body.get_dmged(1)
	queue_free()
