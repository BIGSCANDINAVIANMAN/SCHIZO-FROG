extends Node

var mainScene = preload("res://scenes/main.tscn")
var mahjong = preload('res://scenes/mahjong.tscn')
var cutscene = preload("res://scenes/cutscene.tscn")
var mahjongCutsceneScene = preload("res://scenes/mahjong_cutscene.tscn")
var eatenScene = preload("res://scenes/endScreenFailed.tscn")
var mahjongScene = preload("res://scenes/mahjong.tscn")
var escapedScene = preload("res://scenes/endScreenPassed.tscn")
var levelSelect = preload("res://scenes/level_select.tscn")
var startScreen = preload('res://scenes/start_screen.tscn')
var tutorialScene = preload("res://scenes/tutorial.tscn")

@onready var bgm = $bgm
var openedRestaurantBefore = false
var openedMahjongBefore = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		pause()

func pause():
	get_tree().paused = !get_tree().paused

func _on_main_game_over(result) -> void:
	var gameOverScreen
	if result == "eaten":
		gameOverScreen = eatenScene.instantiate()
		call_deferred("add_child", gameOverScreen)
	elif result == "escaped":
		gameOverScreen = escapedScene.instantiate()
		call_deferred("add_child", gameOverScreen)
	$main.queue_free()
	gameOverScreen.modulate = Color(0, 0, 0)
	await get_tree().create_timer(1).timeout
	gameOverScreen.modulate = Color(1, 1, 1)
	gameOverScreen.connect("exit", returnToMenu.bind(gameOverScreen))

func _on_mahjong_game_over(result) -> void:
	var gameOverScreen
	if result == "eaten":
		gameOverScreen = eatenScene.instantiate()
		call_deferred("add_child", gameOverScreen)
	elif result == "escaped":
		gameOverScreen = escapedScene.instantiate()
		call_deferred("add_child", gameOverScreen)
	$mahjong.queue_free()
	gameOverScreen.modulate = Color(0, 0, 0)
	await get_tree().create_timer(1).timeout
	gameOverScreen.modulate = Color(1, 1, 1)
	gameOverScreen.connect("exit", returnToMenu.bind(gameOverScreen))

func returnToMenu(gameOverScreen):
	await get_tree().create_tween().tween_property(gameOverScreen, "modulate", Color(0, 0, 0), 0.5).finished
	gameOverScreen.queue_free()
	var menuInstance = startScreen.instantiate()
	menuInstance.modulate = Color(0, 0, 0)
	add_child(menuInstance)
	await get_tree().create_tween().tween_property(menuInstance, "modulate", Color(1, 1, 1), 0.5).finished
	menuInstance.connect("startPressed", _on_start_pressed)
	bgm.play()
	bgm.volume_db = 0

func startGame():
	var soundTweener = get_tree().create_tween()
	soundTweener.tween_property($"bgm", "volume_db", -80, 0.5)
	var isLevelSelect = false
	for child in get_children():
		if child.name == "levelSelect":
			isLevelSelect = true
	if isLevelSelect:
		await get_tree().create_tween().tween_property($"levelSelect", "modulate", Color(0, 0, 0), 0.5).finished
		$"levelSelect".queue_free()
	if !openedRestaurantBefore:
		restaurantCutscene()
		return
	
	var tutorial = tutorialScene.instantiate()
	add_child(tutorial)
	tutorial.modulate = Color(0, 0, 0)
	get_tree().create_tween().tween_property(tutorial, "modulate", Color(1, 1, 1), 0.5)
	
	await tutorial.close
	
	tutorial.queue_free()
	var mainInstance = mainScene.instantiate()
	mainInstance.modulate = Color(0, 0, 0)
	add_child(mainInstance)
	mainInstance.connect("gameOver", _on_main_game_over)
	get_tree().create_tween().tween_property(mainInstance, "modulate", Color(1, 1, 1), 0.5)

func startMahjong():
	var soundTweener = get_tree().create_tween()
	soundTweener.tween_property($"bgm", "volume_db", -80, 0.5)
	var isLevelSelect = false
	for child in get_children():
		if child.name == "levelSelect":
			isLevelSelect = true
	if isLevelSelect:
		await get_tree().create_tween().tween_property($"levelSelect", "modulate", Color(0, 0, 0), 0.5).finished
		$"levelSelect".queue_free()
	if !openedMahjongBefore:
		mahjongCutscene()
		return
	var mahjongInstance = mahjongScene.instantiate()
	mahjongInstance.modulate = Color(0, 0, 0)
	add_child(mahjongInstance)
	mahjongInstance.connect("gameOver", _on_mahjong_game_over)
	get_tree().create_tween().tween_property(mahjongInstance, "modulate", Color(1, 1, 1), 0.5)

func restaurantCutscene():
	openedRestaurantBefore = true
	var cutsceneInstance = cutscene.instantiate()
	
	add_child(cutsceneInstance)
	$"levelSelect".queue_free()
	
	cutsceneInstance.modulate = Color(0, 0, 0)
	var tweener2 = get_tree().create_tween()
	tweener2.tween_property(cutsceneInstance, "modulate", Color(1, 1, 1), 0.5)
	
	cutsceneInstance.connect("finished", startGame)

func mahjongCutscene():
	openedMahjongBefore = true
	var cutsceneInstance = mahjongCutsceneScene.instantiate()
	
	add_child(cutsceneInstance)
	
	cutsceneInstance.modulate = Color(0, 0, 0)
	var tweener2 = get_tree().create_tween()
	tweener2.tween_property(cutsceneInstance, "modulate", Color(1, 1, 1), 0.5)
	
	cutsceneInstance.connect("finished", startMahjong)

func _on_start_pressed() -> void:
	var levelSelectInstance = levelSelect.instantiate()
	
	var tweener = get_tree().create_tween()
	tweener.tween_property($"Start Screen", "modulate", Color(0, 0, 0), 0.5)
	await tweener.finished
	
	add_child(levelSelectInstance)
	levelSelectInstance.connect("startRestaurant", startGame)
	levelSelectInstance.connect("startMahjong", startMahjong)
	$"Start Screen".queue_free()
	
	levelSelectInstance.modulate = Color(0, 0, 0)
	var tweener2 = get_tree().create_tween()
	tweener2.tween_property(levelSelectInstance, "modulate", Color(1, 1, 1), 0.5)

func _on_start_screen_start_pressed() -> void:
	_on_start_pressed()
