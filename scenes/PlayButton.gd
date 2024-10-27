extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

@onready var screen = get_node("Screen")
@onready var main = get_node("Main")

func _on_Button_pressed():
	screen.modulate.a = 0
	main.modulate.a = 1
