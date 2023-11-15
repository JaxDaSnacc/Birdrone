extends CharacterBody2D

const MAX_SPEED = 400
const ACCEL = 3.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	var direction = Input.get_axis("left", "right")
	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		velocity.x += direction * 50

	# Get the input direction and handle the movement/deceleration.
	if direction:
		velocity.x += direction * ACCEL
		$Sprite2D.set_flip_h(direction-1)
		velocity.x = clamp(velocity.x, -MAX_SPEED/4 if is_on_floor() else -MAX_SPEED, MAX_SPEED/4 if is_on_floor() else MAX_SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, ACCEL*3 if is_on_floor() else ACCEL*0.5)

	move_and_slide()
