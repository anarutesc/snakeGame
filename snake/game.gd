extends Node

const snakeFood = preload("res://SnakeFood.tscn")
const snakeHead = preload("res://Snake/SnakeHead.tscn")

onready var grid: gridSnake = get_node("gridSnake") as gridSnake

var snakeHeadNode: Node2D
var foodNode: Node2D
var points: int

func _ready():
	init()

func init():
	points = 0
	snakeHeadNode = snakeHead.instance() as Node2D
	foodNode = snakeFood.instance() as Node2D
	
	snakeHeadNode.connect("move", self, "snakeHead_move")
	snakeHeadNode.connect("addBlocksSnakeBody", self, "snakeHead_addBlocks")
	snakeHeadNode.connect("snakeBodyMove", self, "snakeBody_move")
	snakeHeadNode.connect("snakeSize", self, "snake_size")
	
	$gridSnake.connect("gameOver", self, "gameOver_snake")
	$gridSnake.connect("addPoints", self, "addPoints_snake")
	
	add_child(snakeHeadNode)
	move_child(snakeHeadNode, 0)
	grid.placeFoodRandomly(snakeHeadNode)
	
	add_child_below_node(snakeHeadNode, foodNode)
	grid.placeFoodRandomly(foodNode)

func snakeHead_move(snakeHead, direction):
	var contBlocks : int = points + 1
	if contBlocks < grid.grid.size():
		grid.move_snake(snakeHead, direction)
	else:
		print('Você venceu!')
		init()
	
func snakeHead_addBlocks(snakeBodyNode, snakeBodyNode_pos: Vector2):
	var pos : Vector2 = grid.world_to_map(snakeBodyNode_pos)
	add_child_below_node(snakeHeadNode, snakeBodyNode)
	grid.grid[pos.x][pos.y] = snakeBodyNode
	snakeBodyNode.position = snakeBodyNode_pos
	
func snakeBody_move(snakeBodyNode, snakeBodyNode_pos):
	grid.move_snakeBody(snakeBodyNode, snakeBodyNode_pos)
	
func snake_size(snakeBodySize):
	$Control/numPoints.set_text(str(snakeBodySize - 1))
	
func addPoints_snake(foodSnake, snake):
	points += 1
	
	var food: Node2D = snakeFood.instance() as Node2D
	
	if snake.has_method("addPoints"):
		snake.addPoints()
		foodSnake.queue_free()
		
		add_child_below_node(snake, food)
		grid.placeFoodRandomly(food)

func gameOver_snake():
	var snakeHeadBodyTree = get_tree().get_nodes_in_group("snakeHeadBody")
	var snakeFoodTree = get_tree().get_nodes_in_group("snakeFood")
	
	for entity in snakeHeadBodyTree:
		entity.queue_free()
		
	for entity in snakeFoodTree:
		entity.queue_free()
		
	print('Pontuação da partida: ', points)
	init()
