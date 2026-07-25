extends Area2D

var opened = false
@export var door : Node2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == 'knight':
		$Sprite2D.frame = 1
		door.opened = true
