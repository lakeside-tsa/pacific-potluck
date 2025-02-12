extends Area2D

@onready var bar = $Bar
@onready var arrow_path = $Bar/Path2D/PathFollow2D
@onready var score_label = $ScoreLabel
@onready var level_completed_flag = false

signal level_completed

var p1_near_cauldron = false
var p2_near_cauldron = false

static var cooking_quality = {
	"UNDER": 0.01,
	"PERFECT": 0.33,
	"OVER": 0.64,
	"DESTROYED": 0.98
}

var cooking_status = cooking_quality["UNDER"]
var cooking_started = false


func _ready() -> void:
	input_pickable = true
	Global.score = 0
	score_label.text = str(Global.score)
	bar.hide()


func _on_body_entered(_body: Node2D) -> void:
	if _body.name.begins_with("p1_"):
		p1_near_cauldron = true
	elif _body.name.begins_with("p2_"):
		p2_near_cauldron = true


func _on_body_exited(_body: Node2D) -> void:
	if _body.name.begins_with("p1_"):
		p1_near_cauldron = false
	elif _body.name.begins_with("p2_"):
		p2_near_cauldron = false


func _process(_delta: float) -> void:
	var progress = arrow_path.get_path_progress()

	if progress <= 0.0001 :
		bar.hide()
	if progress >= cooking_quality["DESTROYED"] :
		cooking_stop()

	if level_completed_flag == false :
		if p1_near_cauldron and Input.is_action_just_pressed("p1_action"):
			if not cooking_started:
				if %IngredientManager.check_pantry() :
					%IngredientManager.use_ingredients()
					cooking_start()
			else:
				cooking_stop()
		if p2_near_cauldron and Input.is_action_just_pressed("p2_action"):
			if not cooking_started:
				if %IngredientManager.check_pantry() :
					%IngredientManager.use_ingredients()
					cooking_start()
			else:
				cooking_stop()
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

func cooking_stop():
	var progress = 0.0

	progress = arrow_path.get_path_progress()
	arrow_path.path_stop()
	cooking_reset()

	if progress < cooking_quality["PERFECT"]:
		print("cooking_status: UNDER")
		Global.score = Global.score + 1
	elif progress < cooking_quality["OVER"]:
		print("cooking_status: PERFECT")
		Global.score = Global.score + 3
	elif progress < cooking_quality["DESTROYED"]:
		print("cooking_status: OVER")
		Global.score = Global.score + 1
	else:
		print("cooking_status: DESTROYED")

	score_label.text = str(Global.score)

	if Global.score >= 20 :
		level_completed_flag = true
		emit_signal("level_completed")
