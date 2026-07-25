extends Node2D

@export var lvl : PackedScene

var opened = false

func _process(delta: float) -> void:
	if opened:
		$Sprite2D.frame = 1
