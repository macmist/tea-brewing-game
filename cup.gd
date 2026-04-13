extends Node2D
class_name Cup

@onready var sprite: Sprite2D = $Content
@export var brew_speed = 0.02

var water: Color = Color.html('#DDE7F0')
var light_tea: Color = Color.html('#D9A066')
var dark_tea: Color = Color.html('#8B5A2B')
# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	sprite.modulate = water	



func update_color_from_percentage(percentage: int):
	var val =  percentage / 100.0
	sprite.modulate = lerp(water, dark_tea, val)
