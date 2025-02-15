extends CharacterBody2D

const SPEED = 320.0
const ACCELERATION = 2000.0
const DECELERATION = 1500.0
const GRAVITY = Vector2(0, 1200)
const JUMP_VELOCITY = -500.0
const JUMP_CUTOFF = -250.0
const AIR_CONTROL_FACTOR = 0.5

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast: RayCast2D = $RayCast2D

const MAGNET_FORCE = 300.0
const MAGNET_DISTANCE = 80.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += GRAVITY * delta

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$P2Jump.play()

	if Input.is_action_just_released("ui_up") and velocity.y < JUMP_CUTOFF:
		velocity.y = JUMP_CUTOFF

	var direction := Input.get_axis("ui_left", "ui_right")

	if is_on_floor():
		if direction != 0:
			velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)
	else:
		if direction != 0:
			velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta * AIR_CONTROL_FACTOR)
		else:
			velocity.x = move_toward(velocity.x, 0, DECELERATION * delta * AIR_CONTROL_FACTOR)

		if (direction < 0 and velocity.x > 0) or (direction > 0 and velocity.x < 0):
			velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta)

	if not is_on_floor() and raycast.is_colliding() :
		var platform_position = raycast.get_collision_point()
		var distance_to_platform = abs(global_position.x - platform_position.x)

		if distance_to_platform < MAGNET_DISTANCE:
			var pull_direction = sign(platform_position.x - global_position.x)
			velocity.x += pull_direction * MAGNET_FORCE * delta

	move_and_slide()

	if velocity.x < 0:
		animated_sprite_2d.flip_h = false
	elif velocity.x > 0:
		animated_sprite_2d.flip_h = true

	if is_on_floor():
		if abs(velocity.x) > 10:
			set_animation("run")
		else:
			set_animation("idle")
	else:
		set_animation("jump")


func set_animation(name: String) -> void:
	if animated_sprite_2d.animation != name:
		animated_sprite_2d.animation = name
