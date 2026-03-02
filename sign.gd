extends StaticBody2D

@export var item_id: String = ""

@onready var timer: Timer = $Timer
@onready var label: Label = $Label
@onready var item := $Item



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer.is_stopped() && Inventory.request == null:
		timer.start()
	
	if timer.is_stopped():
		label.text = "New Order!"
	else:
		label.text = str(snapped(timer.time_left, 0.1)) + "s"


const item_ids: Array[String] = ["tomato"]
const attributes: Array[String] = ["washed", "diced"]

func _on_timer_timeout() -> void:
	var new_item := item
	new_item.item_id = item_ids.pick_random()
	var attributes_count = randi() % len(attributes)
	
	for i in range(attributes_count):
		var attribute: String = attributes.pick_random()
		if attribute in new_item.attributes:
			continue
		new_item.attributes.append(attribute)
	
	Inventory.request = new_item
	
	item_id = Inventory.request.item_id
	if (Inventory.request.attributes.size() > 0):
		item_id += " (" + ", ".join(Inventory.request.attributes) + ")"
