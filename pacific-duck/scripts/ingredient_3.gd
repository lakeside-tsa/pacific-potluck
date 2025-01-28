extends Area2D

@onready var game_manager = %GameManager

func _on_body_entered(_body: Node2D) -> void:
	print("ing3 des")
	game_manager.add_ing3()
	queue_free()

func _on_body_exited(_body: Node2D) -> void:
	pass
