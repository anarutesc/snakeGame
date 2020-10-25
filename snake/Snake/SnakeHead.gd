extends Node2D

const snakeBody = preload("res://Snake/SnakeBody.tscn")

class_name SnakeHead

onready var direction = Vector2()
onready var snakeBodyArray: Array = [self]

var contDelta = 0

signal move(entity, direction)
signal addBlocksSnakeBody(snakeBodyBlock, snakeBodyPos)
signal snakeBodyMove(snakeBodyBlock, snakeBodyPos)
signal snakeSize(size)

func addPoints():
	var snake : Node2D = snakeBody.instance() as Node2D
	
	snakeBodyArray.append(snake)
	
	emit_signal("addBlocksSnakeBody", snake, snakeBodyArray[-2].position)
	emit_signal("snakeSize", snakeBodyArray.size())

func game_input_detected(new_direction):
	if new_direction != (-1*direction):
		direction = new_direction

func _ready():
	$SpriteHead.connect("input_detected", self, "game_input_detected")
	emit_signal("snakeSize", snakeBodyArray.size())

func _process(delta):
	var posAuxAtual: Vector2 = self.position
	var snakeSizeValue: int = snakeBodyArray.size()
	
	if contDelta > 10:
	
		if direction != Vector2():
			emit_signal("move", self, direction)
			
			if snakeSizeValue > 1:
				for i in range(1, snakeSizeValue):
					var posAux: Vector2 = snakeBodyArray[i].position
					emit_signal("snakeBodyMove", snakeBodyArray[i], posAuxAtual)
					posAuxAtual = posAux
		
		contDelta = 0
			
	contDelta+=1

