extends Camera2D

var target: Node2D

func _physics_process(_delta):
	if target:
		global_position = target.global_position
