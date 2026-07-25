extends CharacterBody2D

var speed = 150
var dashing = false
var facing = "r"

var range
var brange
var dmg
var texture
var type
var area
var posit
var arrowsc

var selecting = false

var can_dmg = true

var hp = 10
var dex = 2
var str = 3
var intl = 0

var shields
var armor
var lvl = 1
var exp = 0
var statpoints = 0
var traits_available = 0
var chosen_traits = []
var gold = 0
var keys
var bombs

var strm
var dexm
var intlm



const GRADES = {
	"-": 0,
	"E": 1,
	"D": 2,
	"C": 3,
	"B": 4,
	"A": 5,
	"S": 6
}

var sword = {
	texture = preload("uid://llxnnimb520m"),
	range = 25,
	brange = 0,
	dmg = 10,
	type = "s",
	area = Vector2(10,20),
	posit = Vector2(0,0),
	str = "C",
	dex = "D",
	intl = "-",
	arrowsc = null
}

func _ready() -> void:
	equip(sword)

func _physics_process(delta: float) -> void:
	var dir = Input.get_vector("ui_left", "ui_right","ui_up","ui_down")
	if dir != Vector2.ZERO:
		if dir.x < 0:
			facing = "l"
		elif dir.x > 0:
			facing = "r"
		velocity = speed * dir
	else:
		velocity = Vector2.ZERO
	animate(dir)
	move_and_slide()

func _process(delta: float) -> void:
	$CanvasLayer/Control2/TextureRect/Label.text = str(str)
	$CanvasLayer/Control2/TextureRect2/Label2.text = str(dex)
	$CanvasLayer/Control2/TextureRect3/Label3.text = str(intl)

func animate(dir):
	if facing == "r":
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
	if dir == Vector2.ZERO:
		$AnimatedSprite2D.play("idle")
	elif dir != Vector2.ZERO and !dashing:
		$AnimatedSprite2D.play("run")
	elif dashing:
		$AnimatedSprite2D.play("dodge")

func equip(thing):
	texture = thing.texture
	range = thing.range
	brange = thing.brange
	dmg = thing.dmg
	type = thing.type
	area = thing.area
	posit = thing.posit
	arrowsc = thing.arrowsc
	
	
	strm = GRADES.get(thing.str, 0)
	dexm = GRADES.get(thing.dex, 0)
	intlm = GRADES.get(thing.intl, 0)
	
	
	$pivot/Sprite2D.position.x = range
	if type == "s":
		$pivot/Sprite2D.rotation = deg_to_rad(90)
	elif type == "b":
		$pivot/Sprite2D.rotation = 0
	$pivot/Sprite2D.texture = texture
	$pivot/Sprite2D/area/CollisionShape2D.shape.size = area
	$pivot/Sprite2D/area/CollisionShape2D.position = posit

func _on_area_body_entered(body: Node2D) -> void:
	if type == "s":
		if body.is_in_group('enemy') and can_dmg:
			can_dmg = false
			var finaldmg = dmg * (1 + (str*strm)/10.0 + (dex*dexm)/10.0 + (intl*intlm)/10.0)
			body.get_dmged(finaldmg)
			get_tree().create_timer(0.1).timeout.connect(dmgres)

func get_dmged(dmg):
	hp -= dmg
	if hp <= 0:
		get_tree().reload_current_scene()

func addxp(amt):
	exp += amt
	if exp >= xp_needed():
		exp -= xp_needed()
		lvl_up()

func xp_needed() -> int:
	return 4 + (lvl - 1) * 2 

func lvl_up():
	lvl += 1
	statpoints += 1
	if lvl % 5 == 0:
		traits_available += 1
	if exp >= xp_needed():
		lvl_up()

func dmgres():
	can_dmg = true

func selupg():
	if statpoints < 0:
		$CanvasLayer/Control.visible = false
		return
	$CanvasLayer/Control.visible = true
	selecting = true

func _on_texture_button_pressed() -> void:
	if selecting:
		str += 1 
		statpoints -=1

func _on_texture_button_2_pressed() -> void:
	if selecting:
		dex += 1
		statpoints -= 1

func _on_texture_button_3_pressed() -> void:
	if selecting:
		intl += 1
		statpoints -= 1
