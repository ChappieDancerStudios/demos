extends KinematicBody2D

# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
const MOTION_SPEED = 160 # Pixels/second

var torchColors = ["#FF0000", "#00FF00", "#0000FF", "#FFFFFF"]


func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("move_up"):
		motion += Vector2(0, -1)
	if Input.is_action_pressed("move_bottom"):
		motion += Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		$Sprite.flip_h = true
		motion += Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		$Sprite.flip_h = false
		motion += Vector2(1, 0)
		
	if Input.is_action_just_pressed("ui_accept"):
		if $Torch.visible:
			$Torch.hide()
		else:
			$Torch.show()
			
	if Input.is_action_just_pressed("light_change") and $Torch.visible:
		var randomIndex = randi()%4
		$Torch.color = Color(torchColors[randomIndex])
	
	motion = motion.normalized() * MOTION_SPEED

	move_and_slide(motion)
