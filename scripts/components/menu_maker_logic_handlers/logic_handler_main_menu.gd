extends Node

@onready var menu_maker: Control = $".."
@onready var string: Label = $"../string"

func _ready() -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	$"../settings".hide()
	button_press("back")
	
	var current_files: PackedStringArray = DirAccess.open("res://-MAPS/-CURRENT/").get_files()
	var current_files_map: String = ""
	for file: String in current_files:
		if file.ends_with(".btmap.tscn"):
			current_files_map = "res://-MAPS/-CURRENT/" + file
	if Engine.get_physics_frames() < 500 and current_files_map:
		global.selected_map = current_files_map
		await get_tree().process_frame
		get_tree().change_scene_to_file("res://scenes/play/play.tscn")
		

func button_press(id: String) -> void:
	
	if id == "back":
		menu_maker.erase()
		string.text = "
label§200§0,1,0.7§Breeze Trials
label§60§0,1,0§v0.1 WIP
button§100§1,1,1§Main Maps§main
button§100§1,1,1§Custom Maps§load_map
button§100§1,1,1§Settings§settings
button§100§1,1,1§Credits§credits

label§50§1,1,1§ 
button§100§1,1,1§Exit§exit
"
		menu_maker._ready()
		
	if id == "main":
		menu_maker.erase()
		string.text = "
button§100§1,1,1§Sandbox§map_sandbox

label§50§1,1,1§ 

label§200§0.5,0,1§Main Maps
button§100§1,1,1§Pulse (By Blengen)§map_pulse
label§150§1,1,0.3§Featured
button§100§1,1,1§High Ridge (By UselessThing)§map_high_ridge

label§50§1,1,1§ 

button§100§1,1,1§Back§back
"
		menu_maker._ready()

	if id == "custom":
		menu_maker.erase()
		string.text = "
label§200§1,0,0.7§Custom Maps
button§100§1,1,1§Play Map§play
button§100§1,1,1§Edit Map§edit
button§100§1,1,1§New Map§new

label§50§1,1,1§ 
button§100§1,1,1§Back§back
"
		menu_maker._ready()

	if id == "settings":
		$"../settings".show()
		$"../settings/menu_maker/logic_handler".update_button_values()

	if id == "credits":
		menu_maker.erase()
		string.text = "
label§200§0,0.5,1§Credits
label§50§0.8,0.8,0.8§Based on Flood Escape 2 by Crazyblox
label§50§0.8,0.8,0.8§Made in Godot Engine

label§100§1,1,1§Tools
button§75§1,1,1§Krita (Raster Editor)§url_https://krita.org
button§75§1,1,1§Inkscape (Vector Editor)§url_https://inkscape.org

label§100§1,1,1§Materials
button§75§1,1,1§FreeStylized§url_https://freestylized.com/
button§75§1,1,1§AmbientCG§url_https://https://ambientcg.com/

label§100§1,1,1§Assets
button§75§1,1,1§OpenGameArt§url_https://opengameart.org
label§35§0.8,0.8,0.8§A full list of all assets from OpenGameArt can be found on GitHub

label§100§1,1,1§Featured Map Makers
button§75§1,1,1§UselessThing (High Ridge)§url_https://www.youtube.com/@UselessThing77

label§50§1,1,1§ 
label§50§0.8,0.8,0.8§Probably forgot a bunch of things lol
button§100§1,1,1§Back§back
label§50§1,1,1§ 
"
		menu_maker._ready()

	if id == "exit": get_tree().quit()
	elif id == "map_sandbox":
		global.selected_map = "res://-MAPS/sandbox.btmap.tscn"
		load_file(global.selected_map)
	elif id == "map_pulse":
		global.selected_map = "res://-MAPS/pulse.btmap.tscn"
		load_file(global.selected_map)
	elif id == "map_high_ridge":
		global.selected_map = "res://-MAPS/high_ridge.btmap.tscn"
		load_file(global.selected_map)
		
		
	elif id == "load_map":
		
		if !settings.warn_files:
			button_press("warn_files")
			return
		
		string.text = "
label§200§1,0.5,0.5§Beware
label§75§1,1,1§.tscn (and therefore .btmap.tscn) files can
label§75§1,1,1§include scripts that are currently unfiltered.
label§75§1,1,1§This includes reading or deleting files on your system
label§75§1,1,0.3§You can open these files in a text editor
label§75§1,1,0.3§and look for \"DirAccess\" to be safe,
label§75§1,1,0.3§but this does not gurantee file safety.
label§75§1,0.75,0.5§Be Vigilant!

label§50§1,1,1§ 

label§50§0.5,0.5,0.5§This warning can be disabled in settings

label§25§1,1,1§ 

button§100§1,1,1§I understand§warn_files
"
		menu_maker.erase()
		menu_maker._ready()
		
	elif id == "warn_files":
		button_press("back")
		$"../../load_map".show()
		
	elif id == "epilepsy_anyway": get_tree().change_scene_to_file("res://scenes/play/play.tscn")

	elif id.begins_with("url_"): OS.shell_open(id.trim_prefix("url_"))









func load_file(path: String) -> void:
	if path == "": return
	global.selected_map = path
	if settings.warn_epilepsy == false: get_tree().change_scene_to_file("res://scenes/play/play.tscn")
	else:
		#await get_tree().process_frame
		var map_check: Node = load(global.selected_map).instantiate()
		map_check = map_check.find_child("settings")
		if map_check.warn_epilepsy == false: get_tree().change_scene_to_file("res://scenes/play/play.tscn")
		else:
			string.text = "
label§200§1,0.5,0.5§Epilepsy Warning
label§75§1,1,1§This map is marked as potentially unsafe
label§75§1,1,1§for people with photosensitive epilepsy
label§75§1,1,1§Stay safe!

label§50§1,1,1§ 

label§50§0.5,0.5,0.5§This warning can be disabled in settings

label§25§1,1,1§ 

button§100§1,1,1§Proceed Anyway§epilepsy_anyway
button§100§1,1,1§Go Back to Main Menu§back"
			menu_maker.erase()
			menu_maker._ready()
