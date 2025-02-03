extends Area2D

@onready var bar = $Bar
@onready var arrow_path = $Bar/Path2D/PathFollow2D

var p1_near_cauldron = false
var p2_near_cauldron = false

static var cooking_quality = {
	"UNDER": 0.01,
	"PERFECT": 0.33,
	"OVER": 0.64
}

var cooking_status = cooking_quality["UNDER"]
var cooking_started = false


func _ready() -> void:
	input_pickable = true
	bar.hide()


func _on_body_entered(_body: Node2D) -> void:
	print("cauldron desu - " + _body.name)
	if _body.name.begins_with("p1_"):
		p1_near_cauldron = true
	elif _body.name.begins_with("p2_"):
		p2_near_cauldron = true


func _on_body_exited(_body: Node2D) -> void:
	if _body.name.begins_with("p1_"):
		p1_near_cauldron = false
	elif _body.name.begins_with("p2_"):
		p2_near_cauldron = false


func _process(delta: float) -> void:
	var progress = arrow_path.get_path_progress()

	if not arrow_path.path_inprogress():
		bar.hide()
	if p1_near_cauldron and Input.is_action_just_pressed("p1_action"):
		print("p1 cauldron action")
		if not cooking_started:
			cooking_start()
		else:
			get_cooking_status()

	#if p2_near_cauldron and Input.is_action_just_pressed("p2_action"):
	#	print("p2 cauldron action")

	if progress >= 0.99:
		cooking_reset()

func cooking_start():
	cooking_reset()
	bar.show()
	cooking_started = true
	arrow_path.path_start()

func cooking_reset():
	bar.hide()
	arrow_path.path_reset()
	cooking_started = false
	cooking_status = cooking_quality["UNDER"]

func get_cooking_status():
	var progress = arrow_path.get_path_progress()
	if progress < cooking_quality["PERFECT"]:
		print("cooking_status: UNDER")
	elif progress >= cooking_quality["OVER"]:
		print("cooking_status: OVER")
	else:
		print("cooking_status: PERFECT")
