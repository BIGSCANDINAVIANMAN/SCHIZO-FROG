extends StaticBody2D

var jongFlightSpeed = 12.5
@export var player: Player
var jongFile = preload("res://scenes/jong.tscn")
@onready var sprite = $sprite

func _ready() -> void:
	await get_tree().create_timer(randf_range(3, 8)).timeout
	$fireJong.start()
	$speedup.start()

func fireJong():
	sprite.play("1")
	var newJong = jongFile.instantiate()
	newJong.velocity = (player.global_position - global_position).normalized() * jongFlightSpeed
	var angle = randf_range(0, 2 * PI)
	newJong.velocity += 3 * Vector2(cos(angle), sin(angle))
	add_sibling(newJong)
	newJong.global_position = global_position
	newJong.rotation = newJong.velocity.angle() + PI / 2

func _on_fire_jong_timeout() -> void:
	fireJong()

func _on_speedup_timeout() -> void:
	return
	$fireJong.wait_time -= 0.5
