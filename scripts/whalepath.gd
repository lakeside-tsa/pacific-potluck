extends PathFollow2D

var speed = 0.015
var direction = 1
@onready var body = $StaticBody2D

func _process(delta):
	progress_ratio += speed * delta * direction

	if progress_ratio >= 1.0:
		progress_ratio = 1.0
		direction = -1
	elif progress_ratio <= 0.0:
		progress_ratio = 0.0
		direction = 1
