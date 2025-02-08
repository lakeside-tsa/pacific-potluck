extends PathFollow2D

var speed = 0.17
var target = 0.99
var running = false

func _process(delta):
	if running:
		path_movement(delta)

func path_start():
	progress_ratio = 0
	path_reset()
	running = true

func path_stop():
	running = false

func path_inprogress():
	return running

func path_reset():
	progress_ratio = 0.0
	target = 0.99
	running = false

func get_path_progress():
	return progress_ratio

func path_movement(delta):
	if progress_ratio < target:
		progress_ratio += delta * speed
