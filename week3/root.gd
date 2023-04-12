extends Node2D

var ball_scene = preload("res://ball.tscn")

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var ball = ball_scene.instantiate()
			ball.position = get_global_mouse_position()
			add_child(ball)
			print("ball created!")
