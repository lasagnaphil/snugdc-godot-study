extends Node

@export var mob_scene: PackedScene
@onready var camera = $CameraPivot/Camera3D
@onready var screen_size = get_viewport().size

func _ready():
	$UserInterface/Retry.hide()

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var screen_positions = [
		Vector2(0, 0),
		Vector2(0, screen_size.y),
		Vector2(screen_size.x, screen_size.y),
		Vector2(screen_size.x, 0)
	]
	
	var plane_positions = []
	for screen_pos in screen_positions:
		var origin = camera.project_ray_origin(screen_pos)
		var dir = camera.project_ray_normal(screen_pos)
		var col_pos = origin - origin.y / dir.y * dir
		plane_positions.push_back(col_pos)
	
	var spawn_pos = Vector3.ZERO
	var t = randf()
	if t < 0.25:
		t = randf()
		spawn_pos = (1 - t) * plane_positions[0] + t * plane_positions[1]
	elif t < 0.5:
		t = randf()
		spawn_pos = (1 - t) * plane_positions[1] + t * plane_positions[2]
	elif t < 0.75:
		t = randf()
		spawn_pos = (1 - t) * plane_positions[2] + t * plane_positions[3]
	else:
		t = randf()
		spawn_pos = (1 - t) * plane_positions[3] + t * plane_positions[0]
	
	mob.initialize(spawn_pos, $Player.position)
	
	add_child(mob)
	
	mob.squashed.connect($UserInterface/ScoreLabel._on_mob_squashed)

func _on_player_hit():
	$MobTimer.stop()
	$UserInterface/Retry.show()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		get_tree().reload_current_scene()
