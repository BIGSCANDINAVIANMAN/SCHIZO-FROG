extends Control

@onready var gameTimer: Timer = $gameTimer
@onready var timerLabel = $timerLabel
@onready var main = get_parent().get_parent()

var schizoWords = {
	["leftRight", true]: "Left and right have been swapped",
	["leftRight", false]: "Left and right are back to normal",
	["upDown", true]: "Up and down have been swapped",
	["upDown", false]: "Up and down are back to normal"
}

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	timerLabel.text = "[center]" + str(floor(gameTimer.time_left)) + "[center]"

var currentTween: Tween

func schizoText(text):
	if currentTween and currentTween.is_running():
		currentTween.kill()
	var schizoLabel = $schizoLabel
	schizoLabel.modulate = Color(1, 1, 1, 1)
	schizoLabel.text = "[center]" + text + "[center]"
	await get_tree().create_timer(0.5).timeout
	currentTween = get_tree().create_tween()
	currentTween.tween_property(schizoLabel, "modulate", Color(1, 1, 1, 0), 2)

func _on_player_schizoed(direction, isSchizo) -> void:
	var keyDict = {
		"upDown": $upKey,
		"leftRight": $leftKey
	}
	var key = keyDict[direction]
	key.modulate = Color(10, 1, 1)
	schizoText(schizoWords[[direction, isSchizo]])
	await get_tree().create_timer(3.7).timeout
	get_tree().create_tween().tween_property(key, "modulate", Color(1, 1, 1), 0.3)

func _on_game_timer_timeout() -> void:
	main.endGame("eaten")

func _on_player_dashed() -> void:
	var key = $rightKey
	key.modulate = Color(10, 1, 1)
	await get_tree().create_timer(3.7).timeout
	get_tree().create_tween().tween_property(key, "modulate", Color(1, 1, 1), 0.3)

func _on_player_teleported() -> void:
	var key = $downKey
	key.modulate = Color(10, 1, 1)
	await get_tree().create_timer(3.7).timeout
	get_tree().create_tween().tween_property(key, "modulate", Color(1, 1, 1), 0.3)
