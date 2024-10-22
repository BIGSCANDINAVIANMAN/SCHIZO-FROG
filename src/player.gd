extends CharacterBody2D
class_name Player

var accel = 40
var drag = 0.1

var controls = {
	"left": "a",
	"right": "d",
	"up": "w",
	"down": "s"
}
var directionLocked = true

func _physics_process(_delta: float) -> void:
	velocity += getDirection() * accel
	velocity = velocity.move_toward(Vector2.ZERO, drag * velocity.length())
	move_and_slide()

func getHit():
	get_tree().change_scene_to_file("res://scenes/fed.tscn")

func win():
	get_tree().change_scene_to_file("res://scenes/hungry.tscn")

func getDirection() -> Vector2:
	var x = Input.get_axis(controls["left"], controls["right"])
	var y = Input.get_axis(controls["up"], controls["down"])
	return Vector2(x, y)
