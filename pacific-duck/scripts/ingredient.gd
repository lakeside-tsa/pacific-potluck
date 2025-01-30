extends Area2D

@onready var ingredient_manager = %IngredientManager

enum IngredientNumber { ING_1 = 0, ING_2, ING_3 }
@export var ingredient_number: IngredientNumber

func _on_body_entered(_body: Node2D) -> void:
	print( "ing " + str(ingredient_number + 1) + " desu")
	ingredient_manager.add_ing(ingredient_number)
	queue_free()

func _on_body_exited(_body: Node2D) -> void:
	pass
