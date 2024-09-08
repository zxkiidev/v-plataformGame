extends CharacterBody2D

var player_velocity = 100
var player_jump = 250
var player_dash = 2
var wall_jump_pushback = 1300
var wall_slide_gravity = 80
var is_wall_sliding = false
var mirando_derecha = false
var gravity = 850
var jump_count = 0
var is_dashing = false

@onready var animPlayer : AnimatedSprite2D = $AnimatedSprite2D 

func _physics_process(delta):
	player_movement()
	animUpdate()
	player_Jump(delta)
	wall_slide(delta)
	move_and_slide()

func animUpdate():
	if is_dashing:
		pass
	elif velocity.x != 0:
		animPlayer.play("Run")
	elif Input.is_action_just_pressed("salto"):
		animPlayer.play("Jump")
	else:
		animPlayer.play("Idle")
			
func player_movement():
	var input_axis = Input.get_axis("izquierda", "derecha")
	
	if is_dashing:
		velocity.x = input_axis * player_velocity * player_dash
	else:
		velocity.x = input_axis * player_velocity
	
	if (mirando_derecha and velocity.x > 0) or (not mirando_derecha and velocity.x < 0):
		scale.x = -1
		mirando_derecha = !mirando_derecha
	
	if Input.is_action_just_pressed("dash"):
		if !is_dashing and input_axis:
			player_dashing()

func player_Jump(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if jump_count == 1 and Input.is_action_just_pressed("salto"):
		velocity.y = -player_jump
		jump_count = 2
		
	if is_on_floor() and Input.is_action_just_pressed("salto"):
		velocity.y = -player_jump
		jump_count = 1
		
	if is_on_floor() and !Input.is_action_just_pressed("salto"):
		jump_count = 0
	
	if Input.is_action_just_pressed("salto"):
		if is_on_wall() and Input.is_action_pressed("derecha"):
			velocity.y = -player_jump 
			velocity.x = -wall_jump_pushback
			
		if is_on_wall() and Input.is_action_pressed("izquierda"):
			velocity.y = -player_jump 
			velocity.x = wall_jump_pushback

func player_dashing():
	is_dashing = true
	$Dash_Timer.disconnect("timeout", stop_dash)
	$Dash_Timer.connect("timeout", stop_dash)
	$Dash_Timer.start()

func stop_dash():
	is_dashing = false

func wall_slide(delta):
	if is_on_wall() and !is_on_floor():
		if Input.is_action_pressed("izquierda") or Input.is_action_pressed("derecha"):
			is_wall_sliding = true
		else:
			is_wall_sliding = false
	else:
		is_wall_sliding = false
		
	if is_wall_sliding:
		velocity.y += (wall_slide_gravity * delta)
		velocity.y = min(velocity.y, wall_slide_gravity)
