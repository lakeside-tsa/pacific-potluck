extends Area2D

@onready var ingredient_manager = %IngredientManager
@onready var sprite_texture = $Sprite2D
@onready var collision_shape = $CollisionShape2D

enum IngredientNumber { ING_1 = 0, ING_2, ING_3 }
@export var ingredient_number: IngredientNumber

func _ready():
	body_entered.connect(_on_body_entered)

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
