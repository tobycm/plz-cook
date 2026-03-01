extends CharacterBody2D

const SPEED = 300.0

func _physics_process(_delta: float) -> void:
	# 1. Get the input direction from the keyboard
	# This returns a Vector2 with an X and Y value between -1 and 1
	var direction := Vector2.ZERO

	if Input.is_action_pressed("ui_left"):
		direction = Vector2(-1, 0)
	elif Input.is_action_pressed("ui_right"):
		direction = Vector2(1, 0)
	elif Input.is_action_pressed("ui_up"):
		direction = Vector2(0, -1)
	elif Input.is_action_pressed("ui_down"):
		direction = Vector2(0, 1)

	if direction != Vector2.ZERO:
		look_at(position + direction)

	velocity = direction * SPEED

	# 3. Tell Godot to actually move the body and handle bumping into counters!
	move_and_slide()


# We grab a reference to that Area2D node we just made
@onready var reach_area = $Reach

func _process(_delta: float) -> void:
	# "ui_accept" is the Spacebar or Enter key by default
	if Input.is_action_just_pressed("ui_accept") || Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		# print("Pressed Accept")
		var overlapping_objects: Array[Area2D] = reach_area.get_overlapping_areas()

		# print(overlapping_objects)

		var filtered_overlapping_objects: Array[Area2D] = overlapping_objects.filter(func(area): return area.is_in_group("ingredients"))
		
		# print(filtered_overlapping_objects)
		
		if filtered_overlapping_objects.size() == 0:
			return

		var object := filtered_overlapping_objects[0]

		if Inventory.holding != "":
			return

		Inventory.holding = object.item_id
		object.queue_free()

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		Inventory.holding = ""
