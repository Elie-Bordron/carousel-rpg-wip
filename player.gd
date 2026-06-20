extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var screen_size
var center = Vector2.ZERO
var current_radius
var radius_to_respect = 3000

func _ready():
	screen_size = get_viewport_rect().size
	center.x = 584
	center.y = 328
	#print("screen_size: ", screen_size)
	#print("center: ", center)
	var my_border = screen_size
	#my_border.x = 
	#print("mine: ", )

func _physics_process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
#		get_node("AnimatedSprite2D").play(), c'est pareil
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	position += velocity * delta
	# to make player stay within viewport boundaries
	#position = position.clamp(Vector2.ZERO, screen_size)
	# to make player stay within carousel
	#current_radius = clamp(abs(position - center), Vector2(0, 0), Vector2(radius_to_respect, radius_to_respect)) 
	#print('current position: ', position)
	#print('carousel center: ', center)
	#print('distance from center: ', position - center)
	#print('distance from center.x normalized: ', (position - center).normalized().x)
	#print('distance from center.y normalized: ', (position - center).normalized().y)
	#print('maximum distance allowed from center: ', current_radius)
	#position = (position - center).normalized() * current_radius
	#print('new position: ', position)
	
	position = clamp_vector(position, center, 300)
	

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "spin"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "spin"
		$AnimatedSprite2D.flip_v = false
		#$AnimatedSprite2D.flip_v = velocity.y > 0

	move_and_slide()
	
func clamp_vector(vector, clamp_origin, clamp_length):
	var offset = vector - clamp_origin
	var offset_length = offset.length()
	if offset_length <= clamp_length:
		return vector
	return clamp_origin + offset * (clamp_length / offset_length)
