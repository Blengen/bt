@tool
extends Sprite3D

@onready var orb: Area3D = $".."

func _process(_delta: float) -> void:
	
	if not Engine.is_editor_hint():
		return
		
	if Engine.get_process_frames() % 40 == 1:
		match orb.type:
			"dash": texture = preload("res://assets/textures/orbs/dash.png")
			"jump": texture = preload("res://assets/textures/orbs/jump.png")
			"stat_speed": texture = preload("res://assets/textures/orbs/stat_speed.png")
			"stat_jump": texture = preload("res://assets/textures/orbs/stat_jump.png")
			"stat_grav": texture = preload("res://assets/textures/orbs/stat_grav_less.png")
			"teleport": texture = preload("res://assets/textures/orbs/teleport.png")
			"fuel": texture = preload("res://assets/textures/orbs/fuel.png")
			"end": texture = preload("res://assets/textures/orbs/end.png")
			_: texture = preload("res://assets/textures/orbs/none.png")
