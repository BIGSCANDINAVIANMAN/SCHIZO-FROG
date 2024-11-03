extends Control

func _on_try_again_button_pressed() -> void:
	get_parent().startGame()
	queue_free()
