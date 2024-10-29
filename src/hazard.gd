extends Area2D

var safeTime = 1

@onready var timer = $safeTime

signal playerEaten

func setWaitTime(time):
	timer.wait_time = time

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		timer.start()

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		timer.stop()

func _on_safe_time_timeout() -> void:
	playerEaten.emit()
	timer.stop()
