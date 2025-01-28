extends Area2D

@onready var ingredient_manager = %IngredientManager

func _on_body_entered(_body: Node2D) -> void:
	print("ing1 des")
	ingredient_manager.add_ing1()
	queue_free()

func _on_body_exited(_body: Node2D) -> void:
	pass
