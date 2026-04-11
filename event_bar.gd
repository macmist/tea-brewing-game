extends Node2D
class_name EventBar

@onready var background: Sprite2D = $Background
@onready var cursor: Sprite2D = $Cursor
@onready var safe_zone: Sprite2D = $Safezone


@export var speed: int = 300

signal reached_end

var end_x = 0
var end_reached = false

var safe_zone_start = 0
var safe_sone_end = 0


func find_safe_zone_bounds():
	var rect = safe_zone.get_rect()
	safe_zone_start= rect.position.x * safe_zone.scale.x
	safe_sone_end = safe_zone_start + rect.size.x * safe_zone.scale.x


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rect = background.get_rect()
	var start_x = rect.position.x * background.scale.x
	end_x = start_x + rect.size.x * background.scale.x
	
	cursor.position.x = start_x
	safe_zone.modulate = Color.GREEN
	find_safe_zone_bounds()
	pass # Replace with function body.

func try_emit_end():
	if !end_reached:
		end_reached = true
		reached_end.emit()

func _process(delta: float) -> void:
	if cursor.position.x >= end_x:
		try_emit_end()
		return
	cursor.position.x += delta * speed
	if cursor.position.x >= safe_zone_start && cursor.position.x <= safe_sone_end:
		cursor.modulate = Color.GREEN
	else:
		cursor.modulate = Color.RED
	if cursor.position.x > end_x:
		cursor.position.x = end_x
		
