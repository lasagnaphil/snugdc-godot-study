extends RigidBody2D

var is_pressed = false

func _integrate_forces(state):
	if is_pressed:
		state.apply_impulse(Vector2(0, -1000))
		is_pressed = false
	
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		is_pressed = true
