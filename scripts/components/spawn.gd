extends Node3D
class_name spawn

@export var time: float = 0

@export var speed: float = 20
@export var jump: float = 60
@export var grav: float = 250
@export var fuel: float = 5

func _ready() -> void:
	update_main_spawn()
	settings.settings_changed.connect(update_main_spawn)

func update_main_spawn() -> void:
	if get_parent().get_child(clamp(settings.current_spawn, 1, get_parent().get_children().size()) - 1) == self:
		global.current_spawn = self
