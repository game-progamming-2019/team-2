extends Node2D

# THIS SCRIPTS JOB IS TO MANAGE LEVELS

var LEVELS = list_files_in_directory("res://Level")
var _current_level = null
var _iterator: int = 0
var _camera_reference = null

func _ready():
	if _iterator < LEVELS.size():
		load_level("res://Level/" + LEVELS[_iterator] + "/level.tscn")

func _process(delta):
	if !check_if_player_is_outside_of_camera():
		death()

func death():
	get_tree().reload_current_scene()
	#$Player.reset()
	
func check_if_player_is_outside_of_camera():
	if _camera_reference:
		return $Player/VisibilityNotifier2D.is_on_screen()
	else:
		print("Camera Unset")

	
func load_level(scene_name: String):
	print(scene_name)
	var level = load(scene_name).instance()
	attach_camera(level)
	level.connect("level_complete", self, "on_level_completed")
	self._current_level = level
	self.add_child(level)
	
func on_level_completed():
	
	self._iterator += 1 
	
	reset_player()
	detach_camera()
	
	self._current_level.queue_free()
	if _iterator >= LEVELS.size():
		print("Looping levels")
		_iterator = 0
	if _iterator < LEVELS.size():
		load_level("res://Level/" + LEVELS[_iterator] + "/level.tscn")

func reset_player():
	$Player.reset()
	$Player.position = Vector2.ZERO
	
func detach_camera():
	#Detach Camera from the Path2D
	var camera = self._current_level.get_node("Path2D/CameraPath/StaticCamera").duplicate()
	self.add_child(camera)
	$StaticCamera.current = true
	self._camera_reference = $StaticCamera
	
func attach_camera(level):
	# Attach the StaticCamera to the Path2D
	var camera = $StaticCamera.duplicate()
	level.get_node("Path2D/CameraPath").add_child(camera)
	level.get_node("Path2D/CameraPath/StaticCamera").current = true
	self._camera_reference = level.get_node("Path2D/CameraPath/StaticCamera")
	$StaticCamera.queue_free()

func list_files_in_directory(path):
    var files = []
    var dir = Directory.new()
    dir.open(path)
    dir.list_dir_begin()
    while true:
        var file = dir.get_next()
        if file == "":
            break
        elif not file.begins_with("."):
            files.push_front(file)
    dir.list_dir_end()
    return files
