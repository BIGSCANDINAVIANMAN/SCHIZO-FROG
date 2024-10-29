extends AnimatedSprite2D

var armSpan = 375.0
var visionAngle = 100.0
var reactionSpeed = 0.1

@export var player: Player
@onready var main = player.get_parent()
@onready var initialRotation = rotation

func _ready() -> void:
	animation = "idle"
	play()
	$hazard.setWaitTime(reactionSpeed)

func eatPlayer():
	animation = "attack"
	var finalRotation = PI / 2 + (player.global_position - global_position).angle()
	get_tree().create_tween().tween_property(self, "rotation", finalRotation, 0.2)
	play()
	await animation_finished
	if $chopstick.overlaps_body(player):
		player.frozen = true
		await get_tree().create_timer(0.5).timeout
		if $chopstick.overlaps_body(player): 
			main.endGame("eaten")
			return
		player.frozen = false
	await get_tree().create_timer(0.3).timeout
	get_tree().create_tween().tween_property(self, "rotation", initialRotation, 0.2)

func _on_hazard_player_eaten() -> void:
	eatPlayer()
