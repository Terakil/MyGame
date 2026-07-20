extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const ROLL_SPEED = 150
var roll_direction = 1
var is_rolling = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#get input dir -1 0 1
	 
	var direction := Input.get_axis("move_left", "move_right")
	
	
		
	#Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	#Animations
	#Handle roll
	if Input.is_action_just_pressed("roulade")and !is_rolling:
		is_rolling = true
		if animated_sprite.flip_h:
			roll_direction=-1
		else:
			roll_direction=1
		animated_sprite.play("roll")
		if roll_direction :
			velocity.x= roll_direction * ROLL_SPEED
	
	
		
	if !is_rolling:
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else :
				animated_sprite.play("run")
		else :
			animated_sprite.play("jump")
	
		#Apply movement
	if !is_rolling:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "roll":
		is_rolling = false
