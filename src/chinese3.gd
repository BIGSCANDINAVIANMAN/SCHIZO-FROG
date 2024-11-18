extends Chinese

func _ready() -> void:
	reactionSpeed = 0.4
	setCaptureTime(0.1)
	$hazard.setWaitTime(reactionSpeed)
	sprite = $sprite
	hazard = $hazard
	chopstickArea = $chopstick
