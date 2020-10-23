extends Node2D

class_name SnakeHead

onready var direction = Vector2()

var contDelta = 0

signal move(entity, direction)

func _ready():
	$SpriteHead.connect("input_detected", self, "game_input_detected")

func _process(delta):
	if(contDelta > 10):
		if direction != Vector2():
			emit_signal("move", self, direction)
		contDelta = 0
			
	contDelta+=1


func game_input_detected(new_direction):
	if new_direction != (-1*direction):
		direction = new_direction
