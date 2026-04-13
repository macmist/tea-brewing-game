extends Node2D

class_name Character

@onready var face: Sprite2D = $Face
@onready var label: Label = $Label

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
	
func make_happy():
	is_served = true
	is_happy =true
	label.text = 'Perfect, thank you!'
	update_face()
	
func make_unhappy(reason: String):
	is_served = true
	is_happy = false
	label.text = reason
	update_face()
	
func init():
	is_served = false
	is_happy = false
	label.text = 'I want some tea please'
	update_face()

func _ready() -> void:
	init()
