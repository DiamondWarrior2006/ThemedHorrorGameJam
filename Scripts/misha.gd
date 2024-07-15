extends CharacterBody2D

@export var pcam : PhantomCamera2D

@export var player_flipped = false

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
	player_movement(delta)
	move_and_slide()
	player_animation()

func player_movement(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
	else:
		if Input.is_action_just_released("jump") and velocity.y < JUMP_VELOCITY / 2:
			velocity.y = JUMP_VELOCITY / 2
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION * delta)
		is_walking = true
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		is_walking = false
	
	# Checking if player is flipped
	if direction == 1:
		player_flipped = false
	elif direction == -1:
		player_flipped = true
	
	if not is_on_floor():
		is_jumping = true
	else:
		is_jumping = false

func player_animation():
	if player_flipped == false:
		if is_walking == true:
			spriteAnim.play("walkingR")
		else:
			spriteAnim.play("idleR")
		if is_jumping == true:
			spriteAnim.play("jumpingR")
	else:
		if is_walking == true:
			spriteAnim.play("walkingL")
		else:
			spriteAnim.play("idleL")
		if is_jumping == true:
			spriteAnim.play("jumpingL")
