extends Area2D

@onready var main = get_parent()
var velocity := Vector2(0, 0)
var sprites = [
"res://assets/the jonging chinese/jongs/Jong # 1.png",
"res://assets/the jonging chinese/jongs/Jong #2.png",
"res://assets/the jonging chinese/jongs/Untitled_Artwork-1.png",
"res://assets/the jonging chinese/jongs/Untitled_Artwork-2.png",
"res://assets/the jonging chinese/jongs/Untitled_Artwork-3.png",
"res://assets/the jonging chinese/jongs/Untitled_Artwork-4.png",
"res://assets/the jonging chinese/jongs/Untitled_Artwork-5.png"]

func _ready() -> void:
	$sprite.texture = load(sprites.pick_random())

func _physics_process(delta: float) -> void:
	global_position += velocity

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.splat()
		await get_tree().create_timer(1).timeout
		main.endGame("eaten")
