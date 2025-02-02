extends Node2D

#var level_1_scene = preload("res://scenes/level_1.tscn")

var current_level: Node
var player1: Node
var player2: Node

func _ready():
	var viewport1 = $GridContainer/SubViewportContainer1/SubViewport
	var viewport2 = $GridContainer/SubViewportContainer2/SubViewport

	viewport2.world_2d = viewport1.world_2d

   # Instance and add GameManager
	var game_manager = preload("res://scenes/game_manager.tscn").instantiate()
	add_child(game_manager)

	game_manager.connect("level_loaded", Callable(self, "_on_level_loaded"))
	game_manager.load_level(1)
	print("ready done")

func _on_level_loaded(level: Node, spawn_point1: Vector2, spawn_point2: Vector2):
	var viewport1 = $GridContainer/SubViewportContainer1/SubViewport
	var viewport2 = $GridContainer/SubViewportContainer2/SubViewport
	
	# Remove previous level if exists
	if current_level:
		current_level.queue_free()
	
	# Add new level to viewport1
	current_level = level
	viewport1.add_child(current_level)
	
	# Instance and add players
	player1 = preload("res://scenes/oscar.tscn").instantiate()
	player2 = preload("res://scenes/abel.tscn").instantiate()
	current_level.add_child(player1)
	current_level.add_child(player2)
	
	# Set player positions
	player1.global_position = spawn_point1
	player2.global_position = spawn_point2

	# Set camera targets
	viewport1.get_node("Camera1").target = player1
	viewport2.get_node("Camera2").target = player2
	
	print("on_level_loaded done")
