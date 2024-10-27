extends Control

@onready var gameTimer: Timer = $gameTimer
@onready var timerLabel = $timerLabel
@onready var textBox = $textBox

func _ready() -> void:
	displayText("visible_ratiovisible_ratiovisible_ratiovisible_ratiovisible_ratiovisible_ratio")

func _physics_process(_delta: float) -> void:
	timerLabel.text = "[center]" + str(floor(gameTimer.time_left)) + "[center]"

func displayText(text):
	textBox.visible = true
	textBox.get_child(0).text = text
	textBox.get_child(0).visible_ratio = 0
	get_tree().create_tween().tween_property($textBox/text, "visible_ratio", 1, len(text)/50.0)
