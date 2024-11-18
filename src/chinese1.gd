extends Chinese

func _ready() -> void:
	reactionSpeed = 0.1
	setCaptureTime(0.3)
	$hazard.setWaitTime(reactionSpeed)
	sprite = $sprite
	hazard = $hazard
	chopstickArea = $chopstick
