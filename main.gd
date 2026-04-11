extends Node2D
@onready var cup: Cup = $Cup
@onready var button: Button = $Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_button_pressed() -> void:
	cup.toggle_brew()
	if cup.is_brewing:
		button.text = "Stop"
	else:
		button.text = "Brew"
