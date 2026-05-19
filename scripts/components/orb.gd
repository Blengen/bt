extends Area3D

@export var type: String = "none"
@export var value: float = 0
@export var tp_node: Node3D
@export var tp_fix_cam: bool

@onready var sprite: Sprite3D = $sprite
@onready var collider: CollisionShape3D = $collider
@onready var timer: Timer = $timer

@onready var player_vars: Node = self

func _ready() -> void:

	timer.timeout.connect(_timeout)
	global.orb_hit.connect(load_texture)
	
	locate_player_vars()
	load_texture()

func locate_player_vars() -> void:
	while not player_vars.is_in_group("root"): player_vars = player_vars.get_parent()
	
	player_vars = player_vars.find_child("player", false)
	player_vars = player_vars.find_child("components", false)
	player_vars = player_vars.find_child("shared_variables", false)
	
func load_texture() -> void:
	match type:
		"dash": sprite.texture = preload("res://assets/textures/orbs/dash.png")
		"jump": sprite.texture = preload("res://assets/textures/orbs/jump.png")
		"stat_speed":
			if player_vars.speed > value: sprite.texture = preload("res://assets/textures/orbs/stat_speed_minus.png")
			else: sprite.texture = preload("res://assets/textures/orbs/stat_speed.png")
		"stat_jump":
			if player_vars.jump > value: sprite.texture = preload("res://assets/textures/orbs/stat_jump_minus.png")
			else: sprite.texture = preload("res://assets/textures/orbs/stat_jump.png")
		"stat_grav":
			if player_vars.grav >= value: sprite.texture = preload("res://assets/textures/orbs/stat_grav_less.png")
			else: sprite.texture = preload("res://assets/textures/orbs/stat_grav_more.png")
		
		"teleport": sprite.texture = preload("res://assets/textures/orbs/teleport.png")
		"fuel": sprite.texture = preload("res://assets/textures/orbs/fuel.png")
		"end": sprite.texture = preload("res://assets/textures/orbs/end.png")
		_: sprite.texture = preload("res://assets/textures/orbs/none.png")


func _timeout() -> void:
	show()
	$collider.disabled = false
