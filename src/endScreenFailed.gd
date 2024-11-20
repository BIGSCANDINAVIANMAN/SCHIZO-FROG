extends Control

signal exit

func _on_exit_pressed() -> void:
	exit.emit()

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	$nom.play()
