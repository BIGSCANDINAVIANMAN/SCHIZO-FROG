extends Chinese

func _ready() -> void:
	setCaptureTime(0.2)
	animation = "idle"
	play()
	$hazard.setWaitTime(reactionSpeed)
