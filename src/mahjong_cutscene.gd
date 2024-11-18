extends Node2D

@onready var cutsceneSprite = $cutscene

func _ready() -> void:
	cutsceneSprite.play("mahjongIntro")

func _on_cutscene_animation_finished() -> void:
	await get_tree().create_timer(3).timeout
	await get_tree().create_tween().tween_property($cutscene, "modulate", Color(0, 0, 0), 2)
	
