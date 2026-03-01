extends Label

@onready var timer = $"../Timer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer.is_stopped():
		text = "Ready"
	else:
		text = str(snapped(timer.time_left, 0.1)) + "s"
