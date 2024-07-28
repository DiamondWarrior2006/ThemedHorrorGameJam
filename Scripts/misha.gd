extends CharacterBody2D

@export var pcam : PhantomCamera2D

@export var player_flipped = false
@export var can_jump = true

@onready var spriteAnim = $AnimatedSprite2D
@onready var cshape = $CollisionShape2D

const ACCELERATION = 600.0
const FRICTION = 800.0
const JUMP_VELOCITY = -300.0

var standing_cshape = preload("res://Collisions/misha_standing_cshape.tres")
var crouching_cshape = preload("res://Collisions/misha_crouching_cshape.tres")

var SPEED 
var normal_speed = 200.0
var crouching_speed = 80.0

var is_walking = false
var is_jumping = false
var is_crouching = false
var can_move = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	SPEED = normal_speed

func _physics_process(delta):
	player_movement(delta)
	move_and_slide()
	player_animation()
	if Dialogic.current_timeline == null:
		can_move = true
	else:
		can_move = false

func player_movement(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if can_move == true:
		# Handle Jump.
		if is_crouching == false:
			if can_jump == true:
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
		
		if Input.is_action_just_pressed("crouch"):
			is_crouching = true
			SPEED = crouching_speed
			cshape.shape = crouching_cshape
			cshape.position.y = 23
		elif Input.is_action_just_released("crouch"):
			is_crouching = false
			SPEED = normal_speed
			cshape.shape = standing_cshape
			cshape.position.y = 9
		
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
		if is_crouching == false:
			if is_walking == true:
				spriteAnim.play("walkingR")
			else:
				spriteAnim.play("idleR")
			if is_jumping == true:
				spriteAnim.play("jumpingR")
		else:
			if is_walking == true:
				spriteAnim.play("crouchwalkR")
			else:
				spriteAnim.play("crouchR")
	else:
		if is_crouching == false:
			if is_walking == true:
				spriteAnim.play("walkingL")
			else:
				spriteAnim.play("idleL")
			if is_jumping == true:
				spriteAnim.play("jumpingL")
		else:
			if is_walking == true:
				spriteAnim.play("crouchwalkL")
			else:
				spriteAnim.play("crouchL")
