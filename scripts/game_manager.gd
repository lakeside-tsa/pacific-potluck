extends Node

@warning_ignore("unused_signal")
signal level_loaded(level, spawn_point1, spawn_point2)

var current_level_number = 0

func load_level(level_number: int):
	current_level_number = level_number

	var level_scene = load("res://scenes/level_" + str(level_number) + ".tscn")
	var level_instance = level_scene.instantiate()
	var spawn_point1 = null
	var spawn_point2 = null

	spawn_point1 = level_instance.get_node("SpawnPoint1").global_position
	spawn_point2 = level_instance.get_node("SpawnPoint2").global_position

	emit_signal("level_loaded", level_instance, spawn_point1, spawn_point2)
	print("level loaded")

func next_level():
	load_level((current_level_number % 4) + 1)
