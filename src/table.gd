extends Area2D

@export var main: Node2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		main.endGame("escaped")
