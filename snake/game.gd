extends Node

const snakeFood = preload("res://SnakeFood.tscn")
const snakeHead = preload("res://Snake/SnakeHead.tscn")

onready var grid: gridSnake = get_node("gridSnake") as gridSnake

var snake_head: Node2D

func _ready():
	snake_head = snakeHead.instance() as Node2D
	snake_head.connect("move", self, "snakeHead_move")
	add_child(snake_head)


func snakeHead_move(snakeHead, direction):
	grid.move_snake(snakeHead, direction)
