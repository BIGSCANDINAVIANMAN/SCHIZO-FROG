extends Node2D

@onready var cutsceneSprite = $cutscene
signal finished

func _ready() -> void:
	cutsceneSprite.play("mahjongIntro")

func _on_cutscene_animation_finished() -> void:
	await get_tree().create_timer(1).timeout
	await get_tree().create_tween().tween_property(self, "modulate", Color(0, 0, 0), 0.5).finished
	finished.emit()
	queue_free()
