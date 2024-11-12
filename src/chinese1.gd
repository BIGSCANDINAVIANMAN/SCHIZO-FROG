extends Chinese

func _ready() -> void:
	setCaptureTime(0.3)
	$hazard.setWaitTime(reactionSpeed)
	sprite = $sprite
	hazard = $hazard
	chopstickArea = $chopstick
