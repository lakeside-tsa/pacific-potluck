extends Node

@onready var overlay = $OverlayScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	overlay.setTopLeft("1: level 1\n2: level 2\n3: level 3\n4: level 4\n\nsecret cheat code: +")
