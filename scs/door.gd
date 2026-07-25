extends Node2D

@export var lvl : PackedScene

var opened = false

func _process(delta: float) -> void:
	if opened:
		$Sprite2D.frame = 1
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "knight":
		get_tree().change_scene_to_file(lvl.resource_path)
