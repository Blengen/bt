extends Node

var selected_map: String = "res://-MAPS/sandbox.btmap.tscn"
var reverse_time_scale: float = 1
var current_spawn: Node3D = null

@warning_ignore_start("unused_signal")
signal restart
signal begin
signal death
signal orb_hit

func _ready() -> void:
	settings.settings_changed.connect(update_values)
	await get_tree().process_frame
	update_values()

func update_values() -> void:
	reverse_time_scale = 1 / Engine.time_scale
	
