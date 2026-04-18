extends Node

var music_enabled = true
var effects_enabled = true
var life_max = 3
var life_left = life_max
var score = 0

signal music_toggled(new_value: bool)
signal effects_toggled(new_value: bool)
signal life_lost()
signal score_changed()
signal game_over()
signal next_customer()
signal init_game()


func add_score(amount: int):
	score += amount
	score_changed.emit()
	
func remove_life():
	if life_left > 0:
		life_left -= 1
		life_lost.emit()
	if life_left <= 0:
		game_over.emit()
	
func get_next_state():
	if life_left <= 0:
		game_over.emit()
	else:
		next_customer.emit()

func toggle_music(toggled_on: bool):
	music_enabled = toggled_on
	music_toggled.emit(toggled_on)
	
func toggle_effects(toggled_on: bool):
	effects_enabled = toggled_on
	effects_toggled.emit(toggled_on)
	
func init():
	life_left = life_max
	score = 0
	score_changed.emit()
	life_lost.emit()
	init_game.emit()
