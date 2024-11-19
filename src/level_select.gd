extends Control

signal startRestaurant
signal startMahjong

func _on_start_mahjong_pressed() -> void:
	startMahjong.emit()

func _on_start_restaurant_pressed() -> void:
	startRestaurant.emit()
