extends Area2D

@export var main: Node2D

func _on_body_exited(body: Node2D) -> void:
	await get_tree().create_timer(0.5).timeout
	if body is Player:
		main.endGame("escaped")
