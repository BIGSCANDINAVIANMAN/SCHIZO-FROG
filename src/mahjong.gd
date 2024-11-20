extends Node2D

signal gameOver(result)

func endGame(result): # eaten or escaped
	gameOver.emit(result)

func _ready() -> void:
	$player.makeOverlayBig()
	await get_tree().create_timer(3).timeout
	await get_tree().create_tween().tween_property($CanvasLayer/schizoLabel, "modulate", Color(1, 1, 1, 0), 0.5).finished
	await get_tree().create_timer(27).timeout
	$gates.queue_free()
