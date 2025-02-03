extends CanvasLayer

func _ready() -> void:
	get_viewport().size = DisplayServer.screen_get_size()
