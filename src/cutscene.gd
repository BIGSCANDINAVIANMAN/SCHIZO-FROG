extends Node2D
@onready var sprite = $sprite
@onready var textBox = $textBox

signal finished

var currentScene = 0
var currentIndex = -1
var sceneInfo = [
	[],
	["Once upon a time, along a gentle river creek, there sat a schizophrenic frog and its family.", "they lived a simple life."], 
	["Until one fateful day, a net swooshed in and caught the poor frog family. "],
	["They were carried to the kitchen and one by one the frog watched as its friends got fried, stir-fried, roasted and grilled."],
	["Just as the unfortunate frog was also about to be cooked, its schizophrenia kicked in...", "in the chaos of its hallucinations, the frog made its escape, leaping onto the dinner table, escaping the hell of being cooked in a restaurant..."], 
	["END"]
]

func _ready() -> void:
	progress()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("leftClick") or Input.is_action_just_pressed("space"):
		if textBox.get_child(0).visible_ratio == 1:
			progress()

func progress():
	if len(sceneInfo[currentScene]) - 1 == currentIndex:
		currentIndex = -1
		currentScene += 1
		progress()
		return
	
	if len(sceneInfo) - 1 == currentScene:
		await get_tree().create_tween().tween_property(self, "modulate", Color(0, 0, 0), 0.5).finished
		finished.emit()
		queue_free()
		return
	
	currentIndex += 1
	sprite.play(str(currentScene))
	displayText(sceneInfo[currentScene][currentIndex])

func displayText(text):
	textBox.visible = true
	textBox.get_child(0).text = text
	textBox.get_child(0).visible_ratio = 0
	get_tree().create_tween().tween_property($textBox/text, "visible_ratio", 1, len(text)/50.0)
