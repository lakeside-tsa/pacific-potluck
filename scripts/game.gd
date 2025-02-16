extends Node

#@warning_ignore("unused_signal")
#signal level_loaded(level, spawn_point1, spawn_point2)
signal level_completed

static var cam_bot = [
	   0, # lv0
	1900, # lv1
	1470, # lv2
	10000, # lv3
	100001, # lv4
]

static var cam_left = [
	   0, # lv0
	-3140, # lv1
	-4140, # lv2
	-10000, # lv3
	-10000, # lv4
]

static var cam_right = [
	  0, # lv0
	2930, # lv1
	4620, # lv2
	10000, # lv3
	10000, # lv411
]


#enum CAM_LT {}
#enum CAM_RT {}

@onready var cam1 = $Splitscreen/CanvasLayer/HBoxContainer/SubViewportContainer1/SubViewport1/Camera1
@onready var cam2 = $Splitscreen/CanvasLayer/HBoxContainer/SubViewportContainer2/SubViewport2/Camera2

@onready var viewport1 = $Splitscreen/CanvasLayer/HBoxContainer/SubViewportContainer1/SubViewport1
@onready var viewport2 = $Splitscreen/CanvasLayer/HBoxContainer/SubViewportContainer2/SubViewport2
@onready var subviewportcontainer2 = $Splitscreen/CanvasLayer/HBoxContainer/SubViewportContainer2

@onready var current_level_number = 0
@onready var current_level_node: Node
@onready var player1: Node
@onready var player2: Node

var current_score = 0

func _ready():
	var level_scene = null
	level_scene = load("res://scenes/level_0.tscn")
	current_level_node = level_scene.instantiate()
	player1 = preload("res://scenes/p3_duck.tscn").instantiate()
	viewport1.add_child(current_level_node)
	current_level_node.add_child(player1)
	player1.hide()
	subviewportcontainer2.hide()
	get_viewport().size = DisplayServer.screen_get_size()


func load_level(level_number: int):
	current_level_number = level_number
	current_score = 0
	var level_scene = load("res://scenes/level_" + str(level_number) + ".tscn")

	if current_level_node:
		current_level_node.queue_free()

	if player1:
		player1.queue_free()
	if player2:
		player2.queue_free()

	subviewportcontainer2.show()

	current_level_node = level_scene.instantiate()
	get_viewport().size = DisplayServer.screen_get_size()
	viewport1.add_child(current_level_node)

	player1 = preload("res://scenes/p1_oscar.tscn").instantiate()
	player2 = preload("res://scenes/p2_abel.tscn").instantiate()
	current_level_node.add_child(player1)
	current_level_node.add_child(player2)
	player1.global_position = current_level_node.get_node("SpawnPoint1").global_position
	player2.global_position = current_level_node.get_node("SpawnPoint2").global_position

	viewport2.world_2d = viewport1.world_2d
	viewport1.get_node("Camera1").target = player1
	viewport2.get_node("Camera2").target = player2

	cam1.limit_bottom = cam_bot[level_number]
	cam2.limit_bottom = cam_bot[level_number]
	cam1.limit_right = cam_right[level_number]
	cam2.limit_right = cam_right[level_number]
	cam1.limit_left = cam_left[level_number]
	cam2.limit_left = cam_left[level_number]

	var cauldron_node = current_level_node.find_child("Cauldron")
	cauldron_node.connect("level_completed", Callable(self, "_on_level_completed"))



func _on_level_completed():
	await get_tree().create_timer(2.0).timeout
	load_level((current_level_number % 4) + 1)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("num01"):
		load_level(1)
	elif event.is_action_pressed("num02"):
		load_level(2)
	elif event.is_action_pressed("num03"):
		load_level(3)
	elif event.is_action_pressed("num04"):
		load_level(4)
	elif current_level_number == 0 and event.is_action_pressed("ui_accept"):
		load_level(1)
