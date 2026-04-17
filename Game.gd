extends Node

var music_enabled = true
var effects_enabled = true

signal music_toggled(new_value: bool)
signal effects_toggled(new_value: bool)


func toggle_music(toggled_on: bool):
	music_enabled = toggled_on
	music_toggled.emit(toggled_on)
	
func toggle_effects(toggled_on: bool):
	effects_enabled = toggled_on
	effects_toggled.emit(toggled_on)
