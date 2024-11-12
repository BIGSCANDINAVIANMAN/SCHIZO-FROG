extends Chinese

func _ready() -> void:
	setCaptureTime(0.2)
	$hazard.setWaitTime(reactionSpeed)
	sprite = $sprite
	hazard = $hazard
	chopstickArea = $chopstick
	reactionSpeed = 0.8
