extends PathFollow2D

var cooking_quality = {
	"UNDER": 0.01,
	"PERFECT": 0.33,
	"OVER": 0.64
}

var speed = 0.2
var target = 0.99
var cooking_status = cooking_quality["UNDER"]

func _process(delta):
	cooking_movement(delta)

func loop_movement(delta):
	progress_ratio += delta * speed

func cooking_reset():
	target = 0.99
	cooking_status = cooking_quality["UNDER"]

func cooking_movement(delta):
	if progress_ratio < target:
		progress_ratio += delta * speed

		if progress_ratio < cooking_quality["PERFECT"]:
			print("cooking_status: UNDER")
		elif progress_ratio > cooking_quality["UNDER"] and progress_ratio < cooking_quality["OVER"]:
			print("cooking_status: PERFECT")
			#target = cooking_quality["PERFECT"]
		elif progress_ratio >= cooking_quality["OVER"]:
			print("cooking_status: OVER")
			#target = cooking_quality["OVER"]
		else:
			pass
	#print("pr: " + str(progress_ratio) )
	#print("delta: " + str(delta) )
