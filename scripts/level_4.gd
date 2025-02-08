extends Node

@onready var ingredient_manager = %IngredientManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ingredient_manager.set_ing_names("Shrimp", "Peppers", "Noodles")
	Dialogic.start("res://dialog/level4.dtl")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
