extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Inventory.holding == null):
		text = ""
	else:
		text = Inventory.holding.item_id
		if (Inventory.holding.attributes.size() > 0):
			text += " (" + ", ".join(Inventory.holding.attributes) + ")"
	
