extends AnimatedSprite2D

var armSpan = 375.0
var visionAngle = 100.0
var reactionSpeed = 0.2

var hazard = preload("res://scenes/hazard.tscn")
@export var player: Player
@onready var main = player.get_parent()
@onready var initialRotation = rotation

func _ready() -> void:
	animation = "idle"
	play()
	attack()

# basically if the player is in the hazard for x sec chinese attack
# after chinese attack if frog dodges the chopstick he survive
func attack():
	var angle = deg_to_rad(-rotation_degrees + randi_range((180 - visionAngle)/2, 180 - (180 - visionAngle)/2))
	var attackPosition = global_position + armSpan * Vector2(cos(angle), sin(angle))
	var newHazard = hazard.instantiate()
	newHazard.safeTime = reactionSpeed
	add_sibling.call_deferred(newHazard)
	newHazard.global_position = attackPosition
	newHazard.connect("playerEaten", playerEaten)

func playerEaten():
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
	await get_tree().create_timer(0.3).timeout
	get_tree().create_tween().tween_property(self, "rotation", initialRotation, 0.2)
