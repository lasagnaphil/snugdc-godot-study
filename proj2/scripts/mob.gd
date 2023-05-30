extends RigidBody2D

signal bullet_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(bullet_body):
	queue_free()
	bullet_body.queue_free()
	bullet_hit.emit()
