extends Area2D
signal hit

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed=400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size=get_viewport().size



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	if velocity.x!=0:
		$AnimatedSprite.animation="walk"
		$AnimatedSprite.flip_v=false
		$AnimatedSprite.flip_h =velocity.x<0
	elif velocity.y!=0:
		$AnimatedSprite.animation="up"
		$AnimatedSprite.flip_v=velocity.y>0


# warning-ignore:unused_argument
func _on_Player_body_entered(body):
	hide()  # Player disappears after being hit.
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
	
	
func start(pos):
	position=pos
	show()
	$CollisionShape2D.disabled=false
