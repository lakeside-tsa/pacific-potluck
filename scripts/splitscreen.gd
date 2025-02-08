extends Node2D

@onready var current_level: Node
@onready var player1: Node
@onready var player2: Node

@onready var viewport1 = $CanvasLayer/HBoxContainer/SubViewportContainer1/SubViewport1
@onready var viewport2 = $CanvasLayer/HBoxContainer/SubViewportContainer2/SubViewport2
@onready var subviewportcontainer2 = $CanvasLayer/HBoxContainer/SubViewportContainer2

@onready var game_manager = preload("res://scenes/game_manager.tscn").instantiate()


func _ready():

	var level_scene = null
	#var level_instance = null

	viewport2.world_2d = viewport1.world_2d

	# Adjust viewport sizes
	get_tree().root.connect("size_changed", Callable(self, "_on_window_resized"))
	_on_window_resized()

	add_child(game_manager)

	game_manager.connect("level_loaded", Callable(self, "_on_level_loaded"))

	get_viewport().size = DisplayServer.screen_get_size()

	level_scene = load("res://scenes/level_0.tscn")
	current_level = level_scene.instantiate()
	viewport1.add_child(current_level)

	player1 = preload("res://scenes/p3_duck.tscn").instantiate()
	current_level.add_child(player1)
	viewport1.get_node("Camera1").target = player1
	viewport2.get_node("Camera2").target = player1

	player1.hide()
	subviewportcontainer2.hide()

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
	subviewportcontainer2.show()

	print("on_level_loaded done")

func _process(delta: float) -> void:
	pass

func _on_window_resized():
	#var window_size = get_viewport().size
	print("Viewport sizes updated: ", viewport1.size)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("num01"):
		game_manager.load_level(1)
	elif event.is_action_pressed("num02"):
		game_manager.load_level(2)
	if event.is_action_pressed("num03"):
		game_manager.load_level(3)
	elif event.is_action_pressed("num04"):
		game_manager.load_level(4)
