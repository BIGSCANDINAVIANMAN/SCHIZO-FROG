extends Area2D

@onready var main = get_parent()
var velocity := Vector2(0, 0)

func _physics_process(delta: float) -> void:
	global_position += velocity

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player.
