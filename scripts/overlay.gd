extends Node2D

@onready var topLeftLabel = $TopLeft

#func _ready() -> void:
#	topLeftLabel.text = "ready"

func setTopLeft(text) -> void:
	topLeftLabel.text = text
