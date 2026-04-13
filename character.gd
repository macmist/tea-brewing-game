extends Node2D

class_name Character

@onready var face: Sprite2D = $Face
@onready var label: Label = $Label

@export var happy: Texture
@export var unhappy: Texture
@export var neutral: Texture
@export var is_served: bool = false
@export var is_happy: bool = false

signal passed_order
signal disappeared

func update_face():
	if !is_served:
		face.texture = neutral
		return
	if is_happy:
		face.texture = happy
	else:
		face.texture = unhappy
		
func appear():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, .3).from(0.0)
	tween.tween_callback(notify_appeared)

func notify_appeared():
	passed_order.emit()

func disappear():
	await get_tree().create_timer(1.0).timeout
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, .3).from(1.0)
	tween.tween_callback(notify_disappeared)
	
func notify_disappeared():
	disappeared.emit()
	
	
func make_happy():
	is_served = true
	is_happy =true
	label.text = 'Perfect, thank you!'
	update_face()
	disappear()
	
func make_unhappy(reason: String):
	is_served = true
	is_happy = false
	label.text = reason
	update_face()
	disappear()
	
func init():
	is_served = false
	is_happy = false
	label.text = 'I want some tea please'
	update_face()
	appear()

func _ready() -> void:
	init()
