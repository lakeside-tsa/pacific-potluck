extends Node

@onready var ingredient_manager = %IngredientManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ingredient_manager.set_ing_names("Rice", "Eggs", "Mushroom")
	Dialogic.clear(DialogicGameHandler.ClearFlags.FULL_CLEAR)
	Dialogic.start("res://dialog/level2.dtl")

func _exit_tree():
	Dialogic.clear(DialogicGameHandler.ClearFlags.FULL_CLEAR)
