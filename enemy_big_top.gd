extends RigidBody2D

@onready var _animated_sprite = $AnimatedSprite2D
var center = Vector2(584, 328)
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	if velocity.length() > 0:
		#velocity = velocity.normalized() * SPEED
		_animated_sprite.play()
	else:
		_animated_sprite.stop()

	#position += velocity * delta
	# to make player stay within carousel	
	position = clamp_vector(position, center, 300)
	
	if velocity.x != 0:
		_animated_sprite.animation = "spin"
		_animated_sprite.flip_v = false
		_animated_sprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		_animated_sprite.animation = "spin"
		_animated_sprite.flip_v = false

	#move_and_slide()
	
	pass
	
func clamp_vector(vector, clamp_origin, clamp_length):
	var offset = vector - clamp_origin
	var offset_length = offset.length()
	if offset_length <= clamp_length:
		return vector
	return clamp_origin + offset * (clamp_length / offset_length)
