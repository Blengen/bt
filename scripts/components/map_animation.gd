extends AnimationPlayer

@export var anim_name: String = ""
@export var speed: float = 1

func _ready() -> void:
	global.restart.connect(reset_anim)
	global.begin.connect(start_anim)
	global.death.connect(pause_anim)
	
func reset_anim() -> void:
	speed_scale = speed
	play("RESET")
	await get_tree().process_frame
	speed_scale = 0
	play(anim_name)
	seek(global.current_spawn.time)

func start_anim() -> void:
	speed_scale = speed

func pause_anim() -> void: speed_scale = 0
