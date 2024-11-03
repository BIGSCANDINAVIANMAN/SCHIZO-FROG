extends Area2D

@export var player: Player
var speed = 0.06

func _physics_process(delta: float) -> void:
	if inPlayer():
		var additionalVelocity = (player.global_position - global_position).orthogonal() * speed
		player.velocity += additionalVelocity
	
	for plate in getPlates():
		var additionalVelocity = 0.1 * (plate.global_position - global_position).orthogonal() * speed
		plate.rotation = (plate.global_position - global_position).angle()
		plate.global_position += additionalVelocity

func inPlayer() -> bool:
	return get_overlapping_bodies().has(player)

func getPlates() -> Array:
	var result = []
	for body in get_overlapping_bodies():
		if body.name.contains("plate"):
			result.append(body)
	return result
