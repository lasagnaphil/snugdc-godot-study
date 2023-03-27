extends Node2D

@onready var ball_tscn = preload("res://ball.tscn")

func _ready():
	var screen_size = get_viewport_rect().size
	for i in range(11):
		var ball = ball_tscn.instantiate()
		ball.position.x = screen_size.x / 2 + 50 * (i - 5);
		ball.position.y = screen_size.y / 2
		$balls.add_child(ball)
