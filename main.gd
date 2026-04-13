extends Node2D
@onready var cup: Cup = $Cup
@onready var button: Button = $Button
@onready var bar: EventBar = $"Event Bar"
@onready var character: Character = $Character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bar.progress.connect(cup.update_color_from_percentage)
	bar.reached_end.connect(end_reached)
	pass # Replace with function body.

func success():
	character.is_served = true
	character.is_happy = true
	character.update_face()

func end_reached():
	button.pressed.emit()

func failed(reason: String = "too bitter"):
	character.is_served = true
	character.is_happy = false
	character.update_face()

func _on_button_pressed() -> void:
	bar.toggle()
	if bar.is_started:
		bar.init()
		character.init()
		button.text = "Stop"
	else:
		var bitterness = bar.get_bitterness()
		if bitterness == 0:
			success()
		elif bitterness == -1:
			failed('too light')
		else:
			failed()
		button.text = "Brew"
