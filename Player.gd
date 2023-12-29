extends CharacterBody2D

@onready var animated_sprite = $Sprite2D
#anime is the worst variable. Even worst than var Ryan. Stupud peoples...
@onready var anime = $AnimationPlayer
@onready var animeTree = $AnimationTree

@export var Speed: int = 50
@export var Friction: float = 0.15
@export var Acceleration: int = 40

var is_moving = false

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.x = Input.get_action_strength("down") - Input.get_action_strength("up")
