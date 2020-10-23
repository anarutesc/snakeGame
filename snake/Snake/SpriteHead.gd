extends Sprite

class_name SpriteHead

signal input_detected(direction)


func _process(delta):
	if Input.is_action_pressed("ui_left"):
		var direction: Vector2 = Vector2(-1, 0)
		emit_signal("input_detected", direction)
	elif Input.is_action_pressed("ui_right"):
		var direction: Vector2 = Vector2(1, 0)
		emit_signal("input_detected", direction)
	elif Input.is_action_pressed("ui_up"):
		var direction: Vector2 = Vector2(0, -1)
		emit_signal("input_detected", direction)
	elif Input.is_action_pressed("ui_down"):
		var direction: Vector2 = Vector2(0, 1)
		emit_signal("input_detected", direction)
