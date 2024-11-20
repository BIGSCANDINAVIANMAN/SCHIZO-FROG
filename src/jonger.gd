extends StaticBody2D

var jongFlightSpeed = 10
@export var player: Player
var jongFile = preload("res://scenes/jong.tscn")
@onready var sprite = $sprite

func _ready() -> void:
	await get_tree().create_timer(randf_range(1, 3)).timeout
	$fireJong.start()
	$speedup.start()

func fireJong():
	sprite.play("1")
	var newJong = jongFile.instantiate()
	var angle = randf_range(0, 2 * PI)
	newJong.velocity = (player.global_position - global_position + 2 * Vector2(cos(angle), sin(angle))).normalized() * jongFlightSpeed
	add_sibling(newJong)
	newJong.global_position = global_position
	newJong.rotation = newJong.velocity.angle() + PI / 2

func _on_fire_jong_timeout() -> void:
	fireJong()

func _on_speedup_timeout() -> void:
	$fireJong.wait_time -= 0.25
