extends Area2D

@export var speed = 400
var screen_size
var orientation = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.animation = "Horizontal"



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x +=1
	if Input.is_action_pressed("move_left"):
		velocity.x -=1
	if Input.is_action_pressed("move_down"):
		velocity.y +=1
	if Input.is_action_pressed("move_up"):
		velocity.y -=1
	if Input.is_action_pressed("attack"):
		$AnimatedSprite2D.animation = "Attack"
		$AnimatedSprite2D.flip_h = orientation
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "Horizontal"
		$AnimatedSprite2D.flip_v = false
		if velocity.x < 0:
			orientation = true
			$AnimatedSprite2D.flip_h = true
		else:
			orientation = false
			$AnimatedSprite2D.flip_h = false
	
	if velocity.y != 0:
		$AnimatedSprite2D.animation = "Vertical"
		$AnimatedSprite2D.flip_v = velocity.y > 0 
