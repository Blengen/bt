extends Node

# NODES #
@onready var pause_ui: Control = $pause_ui
@onready var cam: Camera3D = $"../../player/cambase/cam"
@onready var camlock_ui: TextureRect = $"../../player/components/camera/camlock"

# PLAYER COMPONENTS #
@onready var vars: Node = $"../../player/components/shared_variables"
@onready var camera: Node = $"../../player/components/camera"

func _ready() -> void:
	await get_tree().process_frame
	$pause_ui.hide()
	$pause_ui/settings.hide()
	var map_settings: Node = $"../../map/settings"
	$pause_ui/map_name.text = map_settings.map_name + " - ◆" + str(map_settings.map_difficulty)
	$pause_ui/creators.text = "By " + map_settings.map_creators
	$pause_ui/music.text = "Music: " + map_settings.music_name + " (By " + str(map_settings.music_composer) + ")"
	$pause_ui/license.text = "Music License: " + map_settings.music_license

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc") and !$pause_ui/settings.visible:
		if get_tree().paused == true:
			pause_ui.hide()
			get_tree().paused = false
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			pause_ui.show()
			get_tree().paused = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _process(_delta: float) -> void:
	if get_tree().paused:
		if vars.camlock:
			cam.position.x = 1.5
			camlock_ui.show()
		else:
			cam.position.x = 0
			camlock_ui.hide()
	
