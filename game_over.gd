extends VBoxContainer


func _ready():
	visible = false
	Game.game_over.connect(show)
	Game.init_game.connect(hide)


func _on_restart_pressed() -> void:
	Game.init()
