extends CharacterBody2D
var plr
var fire_cooldown := 2.0
var timer := 0.0

var hp = 50

var dirara
var stopped := false
const PROJECTILE = preload("uid://bs0jrq0f1jxff")

func animate():
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	if velocity != Vector2.ZERO:
		$AnimatedSprite2D.play("walk")
	elif velocity == Vector2.ZERO:
		$AnimatedSprite2D.play("idle")

func _process(delta: float) -> void:
	animate()
	timer += delta
	if timer >= fire_cooldown:
		timer = 0.0
		fire_projectile()
	$ProgressBar.value = hp

func _ready() -> void:
	pick_new_direction()
	$ProgressBar.max_value = hp

func _physics_process(delta: float) -> void:
	if stopped:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	plr = get_parent().get_node('knight')
	$RayCast2D.target_position = dirara * 20  
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		stopped = true
		velocity = Vector2.ZERO
		await get_tree().create_timer(2).timeout
		pick_new_direction()
		stopped = false
	velocity = dirara * 150
	move_and_slide()

func pick_new_direction() -> void:
	dirara = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

func fire_projectile():
	if plr == null:
		return
	var proj = PROJECTILE.instantiate()
	proj.global_position = global_position
	proj.dir = (plr.global_position - global_position).normalized()
	get_parent().add_child(proj)

func get_dmged(dmg):
	hp -= dmg
	if hp <= 0:
		plr.addxp(1)
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "knight":
		body.get_dmged(1)
