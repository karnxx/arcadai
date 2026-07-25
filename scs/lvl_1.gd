extends Node2D

@onready var spawns = $spawn
@onready var e2 = preload("res://scs/enemy.tscn")
@onready var e1 = preload("res://scs/skeleton.tscn")

func _ready() -> void:
	for i in spawns.get_children():
		if randi() % 2 == 0 :
			var en2 = e2.instantiate()
			en2.global_position = i.global_position
			add_child(en2)
		else:
			var en1 = e1.instantiate()
			en1.global_position = i.global_position
			add_child(en1)
