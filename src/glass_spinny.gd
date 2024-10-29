extends Area2D

@export var player: Player
var speed = 0.1

func _physics_process(delta: float) -> void:
	if inPlayer():
		var additionalVelocity = (player.global_position - global_position).orthogonal() * speed
		player.velocity += additionalVelocity

func inPlayer() -> bool:
	return get_overlapping_bodies().has(player)
