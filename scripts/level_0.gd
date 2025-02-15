extends Node

@onready var overlay = $OverlayScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	overlay.setTopLeft("")
