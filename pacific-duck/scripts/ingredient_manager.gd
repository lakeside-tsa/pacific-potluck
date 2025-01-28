extends Node

var ing1 = 0
var ing2 = 0
var ing3 = 0

@onready var ing_counter = $IngCounter

func set_ing_label():
	ing_counter.text = "ing1: " + str(ing1) + "\ning2: " + str(ing2) + "\ning3: " + str(ing3)

func add_ing1():
	ing1 += 1
	print(ing1)
	set_ing_label()

func add_ing2():
	ing2 += 1
	print(ing2)
	set_ing_label()

func add_ing3():
	ing3 += 1
	print(ing3)
	set_ing_label()
