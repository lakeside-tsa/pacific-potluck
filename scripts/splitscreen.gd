extends Node2D

@onready var viewport1 = $CanvasLayer/HBoxContainer/SubViewportContainer1/SubViewport1
@onready var viewport2 = $CanvasLayer/HBoxContainer/SubViewportContainer2/SubViewport2


func _ready():
	get_tree().root.connect("size_changed", Callable(self, "_on_window_resized"))
	_on_window_resized()
	# this can probably be removed:
	get_viewport().size = DisplayServer.screen_get_size()


func _on_window_resized():
	print("Viewport sizes updated: ", viewport1.size)
