extends Node2D
@onready var sprite = $sprite
@onready var textBox = $textBox

signal finished

var currentScene = 0
var currentIndex = -1
var sceneInfo = [
	[],
	["Once upon a time, in 21st century China, along a gentle river creek…", 
	"There sat a schizophrenic frog and its family. They lived a simple life. "],
	["END"]
]

func _ready() -> void:
	progress()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("leftClick") or Input.is_action_just_pressed("space"):
		progress()

func progress():
	if len(sceneInfo[currentScene]) - 1 == currentIndex:
		currentIndex = -1
		currentScene += 1
		progress()
		return
		
	currentIndex += 1
	sprite.play(str(currentScene))
	displayText(sceneInfo[currentScene][currentIndex])

func displayText(text):
	textBox.visible = true
	textBox.get_child(0).text = text
	textBox.get_child(0).visible_ratio = 0
	get_tree().create_tween().tween_property($textBox/text, "visible_ratio", 1, len(text)/30.0)
