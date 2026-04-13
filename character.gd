extends Node2D

class_name Character

@onready var face: Sprite2D = $Face
@export var happy: Texture
@export var unhappy: Texture
@export var neutral: Texture
@export var is_served: bool = false
@export var is_happy: bool = false

func update_face():
	if !is_served:
		face.texture = neutral
		return
	if is_happy:
		face.texture = happy
	else:
		face.texture = unhappy
	
	
func init():
	is_served = false
	is_happy = false
	update_face()

func _ready() -> void:
	init()
