extends Node2D

signal gameOver(result)

func endGame(result): # eaten or escaped
	gameOver.emit(result)
