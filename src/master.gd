extends Node

var mainScene = preload("res://scenes/main.tscn")
var cutscene = preload("res://scenes/cutscene.tscn")
var eatenScene = preload("res://scenes/fed.tscn")
var escapedScene = preload("res://scenes/hungry.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		pause()

func pause():
	get_tree().paused = !get_tree().paused

func _on_main_game_over(result) -> void:
	if result == "eaten":
		call_deferred("add_child", eatenScene.instantiate())
	elif result == "escaped":
		call_deferred("add_child", escapedScene.instantiate())
	$main.queue_free()

func startGame():
	var mainInstance = mainScene.instantiate()
	add_child(mainInstance)
	mainInstance.connect("gameOver", _on_main_game_over)

func _on_start_button_pressed() -> void:
	var cutsceneInstance = cutscene.instantiate()
	
	var tweener = get_tree().create_tween()
	tweener.tween_property($Screen, "modulate", Color(0, 0, 0), 0.5)
	await tweener.finished
	
	add_child(cutsceneInstance)
	cutsceneInstance.connect("finished", startGame)
	$Screen.queue_free()
	
	cutsceneInstance.modulate = Color(0, 0, 0)
	var tweener2 = get_tree().create_tween()
	tweener2.tween_property(cutsceneInstance, "modulate", Color(1, 1, 1), 0.5)
