extends Node2D
class_name EventBar

@onready var background: Sprite2D = $Background
@onready var cursor: Sprite2D = $Cursor
@onready var safe_zone: Sprite2D = $Safezone


@export var start_speed: int = 300
@export var start_safe_zone_size = .4
@export var start_safe_zone_center = .5

var speed = start_speed
var safe_zone_size = start_safe_zone_size
var safe_zone_center = start_safe_zone_center

signal reached_end
signal progress(percent: int)

var start_x = 0
var end_x = 0
var end_reached = false

var safe_zone_start = 0
var safe_zone_end = 0


var is_in_safe_zone = false
var is_started = false

var rng = RandomNumberGenerator.new()
var seed = 'Tea'


func restart():
	speed = start_speed
	safe_zone_size = start_safe_zone_size
	safe_zone_center = start_safe_zone_center
	rng = RandomNumberGenerator.new()
	rng.seed = hash(seed)

func randomize_x():
	var half_size = safe_zone_size * 10 / 2
	safe_zone_center = rng.randi_range(0 + ceil(half_size), 10 - ceil(half_size)) / 10.0
	
	print('center', safe_zone_center, 'size', safe_zone_size, 'speed', speed)
	
func next_difficulty():
	speed += 30
	safe_zone_size -= .01
	if safe_zone_size < .1:
		safe_zone_size = .1
	randomize_x()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rect = background.get_rect()
	start_x = rect.position.x * background.scale.x
	end_x = start_x + rect.size.x * background.scale.x
	safe_zone.modulate = Color.GREEN
	background.modulate = Color.SANDY_BROWN
	init()
	rng.seed = hash(seed)
	
	
func place_safe_zone():
	var zone_center_x = start_x + safe_zone_center * (end_x - start_x)
	print('center: ', zone_center_x, 'ss ', safe_zone_center)
	var zone_width = safe_zone_size * (end_x - start_x)
	safe_zone_start = zone_center_x - zone_width / 2
	safe_zone_end = zone_center_x + zone_width / 2
	safe_zone.position.x = zone_center_x
	safe_zone.scale.x = zone_width

func _draw() -> void:
	var zone_center_x = start_x + safe_zone_center * (end_x - start_x)
	var zone_start_x = zone_center_x - safe_zone_size / 2 * (end_x - start_x)
	var zone_end_x = zone_center_x + safe_zone_size / 2 * (end_x - start_x)
	
	draw_line(Vector2(zone_start_x, 0), Vector2(zone_end_x, 0), Color.GREEN, 2)

func init():
	cursor.position.x = start_x
	place_safe_zone()
	

func toggle():
	is_started = !is_started


func try_emit_end():
	if !end_reached:
		end_reached = true
		reached_end.emit()

func calculate_progress():
	if end_x - start_x == 0:
		return
	var percentage = floor(100 * (cursor.position.x - start_x) / (end_x - start_x))
	progress.emit(percentage)

func get_bitterness():
	if is_in_safe_zone: 
		return 0
	if cursor.position.x < safe_zone_start:
		return -1
	if cursor.position.x > safe_zone_end:
		return 1

func _process(delta: float) -> void:
	if !is_started:
		return
	if cursor.position.x >= end_x:
		try_emit_end()
		return
	cursor.position.x += delta * speed
	is_in_safe_zone =  cursor.position.x >= safe_zone_start && cursor.position.x <= safe_zone_end
	if cursor.position.x > end_x:
		cursor.position.x = end_x
	calculate_progress()
		
