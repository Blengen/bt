extends Node

@onready var label: Label = $debug_label
var spawns: Node = null

func _ready() -> void:
	await get_tree().process_frame
	spawns = $"../../../map/spawns"
	
func _on_timer_timeout() -> void:
	label.text = ""
	
	if settings.show_fps:
		label.text += "FPS: " + str(Engine.get_frames_per_second()) + "
"
	if Engine.time_scale != 1:
		label.text += "Game Speed: " + str(Engine.time_scale) + "
"
	if settings.current_spawn != 1:
		label.text += "Current spawn: " + str(clamp(settings.current_spawn, 1, spawns.get_children().size())) + "
"
