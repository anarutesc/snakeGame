extends TileMap

export var can_move = true

class_name gridSnake

onready var grid_size = Vector2(32, 20)

var grid

func is_inside_screen(pos):
	if( (pos.x >= 0 and pos.x < grid_size.x) and (pos.y >= 0 and pos.y < grid_size.y) ):
		return true
	else:
		return false

func move_snake(snake, direction):
	var pos_aux: Vector2
	var new_grid_pos: Vector2 = world_to_map(snake.position) + direction
	
	if !is_inside_screen(new_grid_pos):
		if new_grid_pos.x >= grid_size.x:
			pos_aux = Vector2(0, new_grid_pos.y)
		if new_grid_pos.x < 0:
			pos_aux = Vector2(grid_size.x - 1, new_grid_pos.y)
		if new_grid_pos.y >= grid_size.y:
			pos_aux = Vector2(new_grid_pos.x, 0)
		if new_grid_pos.y < 0:
			pos_aux = Vector2(new_grid_pos.x, grid_size.y - 1)
		new_grid_pos = pos_aux
		
	grid[world_to_map(snake.position).x][world_to_map(snake.position).y] = null
	grid[new_grid_pos.x][new_grid_pos.y] = snake
	snake.position = map_to_world(new_grid_pos)

func _ready():
	grid = []
	
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
	
