extends Chinese

func _ready() -> void:
	setCaptureTime(0.1)
	$hazard.setWaitTime(reactionSpeed)
	sprite = $sprite
	hazard = $hazard
	chopstickArea = $chopstick
	reactionSpeed = 1
