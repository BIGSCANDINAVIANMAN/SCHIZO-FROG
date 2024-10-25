extends Area2D

var safeTime = 1

@onready var timer = $safeTime

signal playerEaten

func _ready() -> void:
	timer.wait_time = safeTime

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		timer.start()

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		timer.stop()

func _on_safe_time_timeout() -> void:
	playerEaten.emit()
	timer.stop()

func _on_disappear_time_timeout() -> void:
	var tweener = get_tree().create_tween()
	tweener.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.5)
	await tweener.finished
	queue_free()
