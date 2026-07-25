extends Node2D
var opened = false
var hp = 100
@export var rewardweapon : Weapon

func open():
	if opened:
		return
	opened = true
	get_parent().get_node('knight').equip(rewardweapon)

func _process(delta: float) -> void:
	if hp <= 70 and hp > 40:
		$Sprite2D.frame = 1
	elif hp <= 40:
		$Sprite2D.frame = 2
	else:
		$Sprite2D.frame = 0

func get_dmged(dmg):
	hp -= dmg
	shake()
	if hp <= 40:
		open()

func shake():
	var target = deg_to_rad(randf_range(-30, 30))
	var tween = create_tween()
	tween.tween_property(self, "rotation", target, 0.08)
	tween.tween_property(self, "rotation", 0.0, 0.08)
