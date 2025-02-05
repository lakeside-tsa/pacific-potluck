extends Node

var ing_vals = [0, 0, 0]

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

func add_ing(ing_num):
	ing_vals[ing_num] = ing_vals[ing_num] + 1
	set_ing_label()
