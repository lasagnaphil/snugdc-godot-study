extends Area2D

signal hit
signal create_bullet(position: Vector2, velocity: Vector2)

@export var speed = 400
@export var bullet_speed = 800
var dead: bool = false

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	dead = true
	hide()

func _process(delta):
	if dead:
		return
		
	var dir = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		dir.x += 1
	if Input.is_action_pressed("move_left"):
		dir.x -= 1
	if Input.is_action_pressed("move_down"):
		dir.y += 1
	if Input.is_action_pressed("move_up"):
		dir.y -= 1
	
	var velocity: Vector2
	if dir.length() > 0:
		dir = dir.normalized()
		velocity = dir * speed
		$AnimatedSprite2D.play()
	else:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	$AnimatedSprite2D.animation = "walk" if velocity.x != 0 else "up"
	$AnimatedSprite2D.flip_v = velocity.y > 0
	$AnimatedSprite2D.flip_h = velocity.x < 0
	
	if dir.length() > 0 and Input.is_action_just_pressed("shoot"):
		create_bullet.emit(position, dir * bullet_speed)

func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	dead = true

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	dead = false
