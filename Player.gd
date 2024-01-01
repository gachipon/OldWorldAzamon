extends CharacterBody2D

@onready var animated_sprite = $Sprite2D
#anime is the worst variable. Even worse than var Ryan. Stupud peoples...
@onready var anime = $AnimationPlayer
@onready var animeTree = $AnimationTree

@export var Speed: int = 100
@export var Friction: float = 0.05
@export var Acceleration: int = 40

var is_moving = false
var is_attacking = false

func _physics_process(delta):
	if is_attacking == false:
		var input_vector = Vector2.ZERO
		
		input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		input_vector = input_vector.normalized()

		velocity = input_vector * Speed
		
		if input_vector == Vector2.ZERO:
			animeTree.get("parameters/playback").travel("Idle")
		else:
			animeTree.get("parameters/playback").travel("Run")
			animeTree.set("parameters/Idle/blend_position", input_vector)
			animeTree.set("parameters/Run/blend_position", input_vector)
			animeTree.set("parameters/Attack1/blend_position", input_vector)
		move_and_slide()	
	if Input.is_action_just_pressed("Attack"):
		is_attacking = true
		animeTree.get("parameters/playback").travel("Attack1")
		
func finished_attacking():
	is_attacking = false
