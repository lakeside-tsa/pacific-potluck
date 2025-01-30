extends Node

var ing1_val = 0
var ing2_val = 0
var ing3_val = 0

var ing1_name = "ing1"
var ing2_name = "ing2"
var ing3_name = "ing3"


@onready var ing_counter = $IngCounter

func set_ing_label():
	ing_counter.text = ing1_name + ": " + str(ing1_val) + "\n" \
					 + ing2_name + ": " + str(ing2_val) + "\n" \
					 + ing3_name + ": " + str(ing3_val)

func set_ing_names(name1, name2, name3):
	ing1_name = name1
	ing2_name = name2
	ing3_name = name3

func add_ing1():
	ing1_val += 1
	print(ing1_val)
	set_ing_label()

func add_ing2():
	ing2_val += 1
	print(ing2_val)
	set_ing_label()

func add_ing3():
	ing3_val += 1
	print(ing3_val)
	set_ing_label()
