extends KinematicBody2D

export (int) var speed  # How fast the player will move (pixels/sec).
var screensize  # Size of the game window.

func _ready():
	screensize = get_viewport_rect().size

func _physics_process(delta):
	var velocity = Vector2() # The player's movement vector.
	
	if Input.is_action_pressed("ui_right"):
		velocity += Vector2(1, 0)
	if Input.is_action_pressed("ui_left"):
		velocity += Vector2(-1, 0)
	if Input.is_action_pressed("ui_down"):
		velocity += Vector2(0, 1)
	if Input.is_action_pressed("ui_up"):
		velocity += Vector2(0, -1)
	
	if velocity.x != 0: # Change horizontal orientation
		$AnimatedSprite.flip_h = velocity.x < 0
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	if Input.is_action_pressed("ui_select"): # Stabbing animation
		$AnimatedSprite.play("stabbing")
	elif velocity.length() > 0: # Walking animation
		$AnimatedSprite.play("walking")
	else: # No animation
		$AnimatedSprite.stop()
		
	move_and_slide(velocity)