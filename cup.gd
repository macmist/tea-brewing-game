extends Node2D
class_name Cup

@onready var sprite: Sprite2D = $Content
@export var brew_speed = 0.02

var light_tea: Color = Color.html('#D9A066')
var dark_tea: Color = Color.html('#8B5A2B')
# Called when the node enters the scene tree for the first time.

var is_brewing = false

var time = 0
func _ready() -> void:
	sprite.modulate = light_tea	

func toggle_brew():
	is_brewing = !is_brewing




func _physics_process(delta: float) -> void:
	if !is_brewing:
		return
	time += delta * brew_speed	
	time = clampf(time, 0.0, 1.0)

	sprite.modulate = lerp(sprite.modulate, dark_tea, time)
