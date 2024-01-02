extends CharacterBody2D

@onready var animated_sprite = $Sprite2D
#anime is the worst variable. Even worse than var Ryan. Stupud peoples...
@onready var anime = $AnimationPlayer
@onready var animeTree = $AnimationTree
@onready var AtkTimer = $AttackTimer

# Good to initialize type for LOW END POTATO PCs PERFORMANCE
@export var Speed: int = 100
@export var Friction: float = 0.05
@export var Acceleration: int = 40
@export var AtkNumber: int = 3

var is_moving = false
var is_attacking = false

func _ready():
	animeTree.active = true

func _physics_process(delta):
	if is_attacking == false:
		var input_vector = Vector2.ZERO
		
		# THIS MOVES PLAYER
		input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		input_vector = input_vector.normalized()

		velocity = input_vector * Speed
		
		# THIS GETS PLAYER ANIMATION
		if input_vector == Vector2.ZERO:
			animeTree.get("parameters/playback").travel("Idle")
		else:
			animeTree.get("parameters/playback").travel("Run")
			animeTree.set("parameters/Idle/blend_position", input_vector)
			animeTree.set("parameters/Run/blend_position", input_vector)
			animeTree.set("parameters/Attack1/blend_position", input_vector)
			animeTree.set("parameters/Attack2/blend_position", input_vector)
			animeTree.set("parameters/Attack3/blend_position", input_vector)
		move()
		
	attack_combo()
	
func attack_combo():
	if Input.is_action_just_pressed("Attack") and AtkNumber == 3:
		is_attacking = true
		AtkTimer.start()
		animeTree.get("parameters/playback").travel("Attack1")
	if Input.is_action_just_pressed("Attack") and AtkNumber == 2:
		is_attacking = true
		AtkTimer.start()
		animeTree.get("parameters/playback").travel("Attack2")
	if Input.is_action_just_pressed("Attack") and AtkNumber == 1:
		is_attacking = true
		AtkTimer.start()
		animeTree.get("parameters/playback").travel("Attack3")
		
func remove_atknumb():
	AtkNumber -= 1
		
func finished_attacking():
	is_attacking = false

func move():
	move_and_slide()

func _on_attack_timer_timeout():
	AtkNumber = 3
	is_attacking = false
