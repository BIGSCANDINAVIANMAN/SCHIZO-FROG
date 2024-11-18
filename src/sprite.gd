extends AnimatedSprite2D

@onready var player = get_parent()
var frameInfo = {
	Vector2(0, 1): 0,
	Vector2(1, 1): 1,
	Vector2(1, 0): 2,
	Vector2(1, -1): 3,
	Vector2(0, -1): 4,
	Vector2(-1, -1): 5,
	Vector2(-1, 0): 6,
	Vector2(-1, 1): 7
}

var dashInfo = {
	Vector2(0, 1): 8,
	Vector2(1, 1): 9,
	Vector2(1, 0): 10,
	Vector2(1, -1): 11,
	Vector2(0, -1): 12,
	Vector2(-1, -1): 13,
	Vector2(-1, 0): 14,
	Vector2(-1, 1): 15
}

var teleportInfo = {
	Vector2(0, 1): 16,
	Vector2(1, 1): 20,
	Vector2(1, 0): 24,
	Vector2(1, -1): 28,
	Vector2(0, -1): 0,
	Vector2(-1, -1): 4,
	Vector2(-1, 0): 8,
	Vector2(-1, 1): 12
}

func _ready() -> void:
	animation = "walkRun"

func _process(_delta: float) -> void:
	if player.getDirection():
		frame = frameInfo[player.getDirection()]

func dashAnimation():
	var dashSprite = $"../dashSprite"
	if !dashInfo.get(player.getDirection()):
		return
	dashSprite.frame = dashInfo[player.getDirection()]
	dashSprite.modulate.a = 1
	await get_tree().create_timer(0.1).timeout
	var tweener = get_tree().create_tween()
	tweener.tween_property(dashSprite, "modulate", Color(1, 1, 1, 0), 0.5)

func teleportAnimation():
	animation = "teleport"
	var startingFrame = teleportInfo[player.directionFacing]
	frame = startingFrame
	var tweener = get_tree().create_tween()
	tweener.tween_property(self, "frame", startingFrame + 3, 0.3)
	await tweener.finished
	await get_tree().create_timer(0.1).timeout
	frame = 32
	await $"../schizophrenia".foundPosition
	await get_tree().create_timer(0.3).timeout
	frame = startingFrame + 3
	var tweener2 = get_tree().create_tween()
	tweener2.tween_property(self, "frame", startingFrame, 0.3)
	await tweener2.finished
	animation = "walkRun"

func _on_schizophrenia_dashed() -> void:
	dashAnimation()

func _on_schizophrenia_teleported() -> void:
	teleportAnimation()
