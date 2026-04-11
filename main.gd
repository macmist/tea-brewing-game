extends Node2D
@onready var cup: Cup = $Cup
@onready var button: Button = $Button
@onready var bar: EventBar = $"Event Bar"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bar.progress.connect(cup.update_color_from_percentage)
	pass # Replace with function body.



func _on_button_pressed() -> void:
	bar.toggle()
	if bar.is_started:
		button.text = "Stop"
	else:
		button.text = "Brew"
