extends StaticBody2D
class_name Chinese

var reactionSpeed = 0.2
var captureTime = 0

@export var player: Player
@onready var main = player.get_parent()
@onready var initialRotation = rotation
@onready var sprite: AnimatedSprite2D
var hazard: Area2D
var chopstickArea: Area2D

func setCaptureTime(time):
	captureTime = time

func eatPlayer():
	hazard.monitoring = false
	var angle = (player.global_position - global_position).angle()
	print(angle)
	
	var finalRotation = angle
	var tweener = get_tree().create_tween()
	tweener.tween_property(self, "rotation", finalRotation, 0.2 * abs(finalRotation - rotation)).finished
	await tweener.finished
	sprite.play("attack")
	if captureTime:
		await get_tree().create_timer(captureTime).timeout
	if chopstickArea.overlaps_body(player):
		player.visible = false
		player.frozen = true
		await sprite.animation_finished
		await get_tree().create_timer(0.3).timeout
		main.endGame("eaten")
		return
	await sprite.animation_finished
	var newTweener = get_tree().create_tween()
	newTweener.tween_property(self, "rotation", initialRotation, 0.4)
	sprite.play("idle")
	await newTweener.finished
	await get_tree().create_timer(1).timeout
	hazard.monitoring = true
	if hazard.overlaps_body(player):
		eatPlayer()

func _on_hazard_player_eaten() -> void:
	eatPlayer()
