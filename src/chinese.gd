extends AnimatedSprite2D
class_name Chinese

var reactionSpeed = 0.2
var captureTime = 0

@export var player: Player
@onready var main = player.get_parent()
@onready var initialRotation = rotation
var hazard: Area2D
var chopstickArea: Area2D

func setCaptureTime(time):
	captureTime = time

func eatPlayer():
	var finalRotation = PI / 2 + (player.global_position - global_position).angle()
	var tweener = get_tree().create_tween()
	tweener.tween_property(self, "rotation", finalRotation, 0.2 * abs(finalRotation - rotation)).finished
	await tweener.finished
	play("attack")
	if captureTime:
		await get_tree().create_timer(captureTime).timeout
	if $chopstick.overlaps_body(player):
		if $chopstick.overlaps_body(player): 
			player.visible = false
			player.frozen = true
			await animation_finished
			await get_tree().create_timer(0.5).timeout
			main.endGame("eaten")
			return
	await animation_finished
	await get_tree().create_tween().tween_property(self, "rotation", initialRotation, 0.2).finished
	if hazard.overlaps_body(player):
		eatPlayer()

func _on_hazard_player_eaten() -> void:
	eatPlayer()
