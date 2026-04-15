extends Node2D
@onready var cup: Cup = $Cup
@onready var bar: EventBar = $"Event Bar"
@onready var character: Character = $Character
@onready var button: Button = $CanvasLayer/MarginContainer/Button

var failures = 0
var failures_max = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bar.progress.connect(cup.update_color_from_percentage)
	bar.reached_end.connect(end_reached)
	character.passed_order.connect(start)
	character.disappeared.connect(next_customer)
	pass # Replace with function body.
	
func next_customer():
	if failures < failures_max:
		character.init()
	else:
		print('game over')

func start():
	bar.visible = true
	bar.init()
	button.visible = true
	button.text = 'brew'

func success():
	character.make_happy()
	bar.visible = false
	bar.next_difficulty()

func end_reached():
	button.pressed.emit()

func failed(reason: String = "too bitter"):
	character.make_unhappy(reason)
	bar.visible = false
	failures+=1

func _on_button_pressed() -> void:
	bar.toggle()
	if bar.is_started:
		button.text = "Stop"
	else:
		button.visible = false
		var bitterness = bar.get_bitterness()
		if bitterness == 0:
			success()
		elif bitterness == -1:
			failed('too light')
		else:
			failed()
		
