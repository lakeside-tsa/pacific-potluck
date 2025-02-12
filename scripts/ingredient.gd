extends Area2D

@onready var ingredient_manager = %IngredientManager

enum IngredientNumber { ING_1 = 0, ING_2, ING_3 }
@export var ingredient_number: IngredientNumber

func _on_body_entered(_body: Node2D) -> void:
	var collision_original = collision_mask
	print( "ing " + str(ingredient_number + 1) + " desu")
	ingredient_manager.add_ing(ingredient_number)
	collision_mask = 0
	hide()
	await get_tree().create_timer(10.0).timeout
	show()
	collision_mask = collision_original

func _on_body_exited(_body: Node2D) -> void:
	pass
