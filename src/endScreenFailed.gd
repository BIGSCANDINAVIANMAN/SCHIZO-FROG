extends Control

signal exit

func _on_start_mahjong_pressed() -> void:
	exit.emit()
