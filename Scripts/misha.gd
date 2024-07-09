extends CharacterBody2D

@export var pcam : PhantomCamera2D

@onready var spriteAnim = $AnimatedSprite2D

const SPEED = 200.0
const ACCELERATION = 600.0
const FRICTION = 800.0
const JUMP_VELOCITY = -300.0

var is_walking = false
var is_jumping = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		is_jumping = false

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION * delta)
		is_walking = true
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		is_walking = false
	
	if direction == 1:
		spriteAnim.flip_h = false
	elif direction == -1:
		spriteAnim.flip_h = true
	

	move_and_slide()
	player_animation()

func player_animation():
	if is_walking == true:
		spriteAnim.play("walking")
	else:
		spriteAnim.play("idle")
