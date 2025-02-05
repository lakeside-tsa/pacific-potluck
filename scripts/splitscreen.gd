extends Node2D

var current_level: Node
var player1: Node
var player2: Node

@onready var viewport1 = $CanvasLayer/HBoxContainer/SubViewportContainer1/SubViewport1
@onready var viewport2 = $CanvasLayer/HBoxContainer/SubViewportContainer2/SubViewport2

func _ready():

	viewport2.world_2d = viewport1.world_2d

	# Adjust viewport sizes
	get_tree().root.connect("size_changed", Callable(self, "_on_window_resized"))
	_on_window_resized()

	var game_manager = preload("res://scenes/game_manager.tscn").instantiate()
	add_child(game_manager)

	game_manager.connect("level_loaded", Callable(self, "_on_level_loaded"))
	game_manager.load_level(1)

	Dialogic.start("res://dialog/timeline.dtl")
	print("Viewport1 size: ", viewport1.size)
	print("Viewport2 size: ", viewport2.size)
	print("ready done")

func _on_level_loaded(level: Node, spawn_point1: Vector2, spawn_point2: Vector2):

	print("on_level_loaded started")

	# Remove previous level if it exists
	if current_level:
		current_level.queue_free()

	current_level = level
	viewport1.add_child(current_level)
	# 問題
	#var level_clone = current_level.duplicate()
	#viewport2.add_child(level_clone)
	
	# Instance and add players
	player1 = preload("res://scenes/p1_oscar.tscn").instantiate()
	player2 = preload("res://scenes/p2_abel.tscn").instantiate()
	current_level.add_child(player1)
	current_level.add_child(player2)

	# Set player positions
	player1.global_position = spawn_point1
	player2.global_position = spawn_point2

	# Set camera targets
	viewport1.get_node("Camera1").target = player1
	viewport2.get_node("Camera2").target = player2

	print("on_level_loaded done")

func _on_window_resized():
	var window_size = get_viewport().size
	print("Viewport sizes updated: ", viewport1.size)
