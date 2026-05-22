extends Node

# MAP_INFO #
@export var map_name: String = ""
@export var map_creators: String
@export var map_difficulty: float = 2

# MUSIC_INFO #
@export var music_name: String = ""
@export var music_volume: float = 1
@export var music_file: String = ".mp3"
@export var music_composer: String = ""
@export var music_license: String = "CC"

@export var warn_epilepsy: bool = false

@onready var music_node: AudioStreamPlayer = $music
func _ready() -> void:
	
	global.restart.connect(func stop_music() -> void: music_node.playing = false)
	global.begin.connect(start_music)
	
	settings.settings_changed.connect(update)
	update()

func start_music() -> void:
	music_node.seek(global.current_spawn.time)
	music_node.playing = true
	await get_tree().process_frame
	music_node.seek(global.current_spawn.time)

func update() -> void:
	music_node.pitch_scale = Engine.time_scale
	music_node.volume_linear = music_volume * settings.music_volume
