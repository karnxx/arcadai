extends Resource
class_name Weapon

@export var texture : Texture2D
@export var range : int
@export var brange : int
@export var dmg : int
@export_enum("s", "b") var type : String
@export var area : Vector2
@export var posit : Vector2
@export_enum("S", "A", "B", "C", "D", "E", "-") var str : String
@export_enum("S", "A", "B", "C", "D", "E", "-") var dex : String
@export_enum("S", "A", "B", "C", "D", "E", "-") var intl : String
@export var arrowsc : PackedScene
