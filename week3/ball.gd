extends RigidBody2D

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			var impulse_x = randf_range(-250, 250)
			var impulse_y = randf_range(-1000, -500)
			apply_impulse(Vector2(impulse_x, impulse_y))
			print("impulse (%d %d) added!" % [impulse_x, impulse_y])


func _on_body_entered(body):
	const MIN_VOLUME_VEL: float = 5
	const MAX_VOLUME_VEL: float = 300
	var vel_diff: float = 0
	if body is StaticBody2D:
		vel_diff = (linear_velocity - body.constant_linear_velocity).length()
	elif body is RigidBody2D:
		vel_diff = (linear_velocity - body.linear_velocity).length()
	if vel_diff > MIN_VOLUME_VEL:
		var vel_normalized = clamp((vel_diff - MIN_VOLUME_VEL) / (MAX_VOLUME_VEL - MIN_VOLUME_VEL), 0.01, 1.0)
		var volume_db = 20 * log(vel_normalized)
		$collide_sound_player.volume_db = volume_db
		$collide_sound_player.play()
		print("ball collided with sound %f db" % volume_db)
