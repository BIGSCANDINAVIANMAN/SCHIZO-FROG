extends Control

@onready var gameTimer: Timer = $gameTimer
@onready var timerLabel = $timerLabel
@onready var main = get_parent().get_parent()

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	timerLabel.text = "[center]" + str(floor(gameTimer.time_left)) + "[center]"

func _on_game_timer_timeout() -> void:
	main.endGame("eaten")
