extends Node2D

@onready var cutsceneSprite = $CanvasLayer/cutscene
@onready var bg = $CanvasLayer/bg
@onready var player = $player

func _ready() -> void:
	player.frozen = true
	cutsceneSprite.visible = true
	bg.visible = true
	cutsceneSprite.play("mahjongIntro")

func _on_cutscene_animation_finished() -> void:
	await get_tree().create_timer(1).timeout
	await get_tree().create_tween().tween_property(cutsceneSprite, "modulate", Color(0, 0, 0), 1).finished
	cutsceneSprite.visible = false
	await get_tree().create_tween().tween_property(bg, "modulate", Color(0, 0, 0, 0), 1).finished
	bg.visible = false
	player.frozen = false
