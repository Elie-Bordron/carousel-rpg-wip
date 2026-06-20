extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

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
	position = position.clamp(Vector2.ZERO, screen_size)

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
