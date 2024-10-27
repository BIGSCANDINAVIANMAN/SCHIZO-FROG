extends Control

@onready var gameTimer: Timer = $gameTimer
@onready var timerLabel = $timerLabel

func _physics_process(_delta: float) -> void:
	timerLabel.text = "[center]" + str(floor(gameTimer.time_left)) + "[center]"
