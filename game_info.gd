extends MarginContainer

@onready var score: Label = $VBoxContainer/Score
@onready var life: Label = $VBoxContainer/Life

var heart_full = '❤️'
var heart_miss = '💔'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.score_changed.connect(update_score)
	Game.life_lost.connect(update_life)
	Game.game_over.connect(hide)
	Game.init_game.connect(show)
	update_life()
	update_score()


func update_score():
	score.text = str(Game.score)
	
func update_life():
	var final_str = ''
	for i in range(0, Game.life_left):
		final_str += heart_full
	for i in range(Game.life_left, Game.life_max):
		final_str += heart_miss
	life.text = final_str
