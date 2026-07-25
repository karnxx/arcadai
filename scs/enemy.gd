extends CharacterBody2D

var speed = 80
var hp = 100
var dmg = 5
var xp_reward = 2
var dirara := Vector2.ZERO
var stopped := false
var can_dmg = true

func _ready() -> void:
	add_to_group("enemy")
	$ProgressBar.max_value = hp
	pick_new_direction()

func _physics_process(delta: float) -> void:
	if stopped:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	$ProgressBar.value = hp
	$RayCast2D.target_position = dirara * 20
	$RayCast2D.force_raycast_update()

	if $RayCast2D.is_colliding():
		stopped = true
		velocity = Vector2.ZERO
		move_and_slide()
		await get_tree().create_timer(1.0).timeout
		pick_new_direction()
		stopped = false
		return

	animate()
	velocity = dirara * speed
	move_and_slide()

func animate():
	if dirara.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif dirara.x > 0:
		$AnimatedSprite2D.flip_h = false
	$AnimatedSprite2D.play("walk")

func pick_new_direction() -> void:
	dirara = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

func get_dmged(amount):
	hp -= amount
	if hp <= 0:
		die()

func die():
	var knight = get_tree().get_first_node_in_group("player")
	if knight:
		knight.addxp(xp_reward)
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "knight" and can_dmg:
		can_dmg = false
		body.get_dmged(dmg)
		await get_tree().create_timer(0.5).timeout
		can_dmg = true
