extends Node2D

func _process(delta: float) -> void:
	rotation += get_angle_to(get_global_mouse_position())
