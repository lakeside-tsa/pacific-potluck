extends Node

var ing_vals: Array[int] = [0, 0, 0]

var ing1_name = "ing1"
var ing2_name = "ing2"
var ing3_name = "ing3"

@onready var ing_counter = $IngCounter

func set_ing_label():
	ing_counter.text = ing1_name + ": " + str(ing_vals[0]) + "\n" \
					 + ing2_name + ": " + str(ing_vals[1]) + "\n" \
					 + ing3_name + ": " + str(ing_vals[2])


func set_ing_names(name1, name2, name3):
	ing1_name = name1
	ing2_name = name2
	ing3_name = name3


func check_pantry() -> bool:
	if ing_vals[0] > 0 and ing_vals[1] > 0 and ing_vals[2] > 0:
		return true
	return false


func use_ingredients() -> void:
	ing_vals[0] = ing_vals[0] - 1
	ing_vals[1] = ing_vals[1] - 1
	ing_vals[2] = ing_vals[2] - 1
	set_ing_label()


func add_ing(ing_num):
	ing_vals[ing_num] = ing_vals[ing_num] + 1
	if OS.is_debug_build():
		add_more_ing(ing_num)
	set_ing_label()


func add_more_ing(ing_num):
	ing_vals[0] += randi() % 5 + 1
	ing_vals[1] += randi() % 5 + 1
	ing_vals[2] += randi() % 5 + 1
	set_ing_label()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("key_plus") :
		add_more_ing(randi() % 3)
