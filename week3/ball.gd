extends RigidBody2D

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			apply_impulse(Vector2(0, -1000))
			print("impulse added!")
