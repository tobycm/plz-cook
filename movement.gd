extends CharacterBody2D

const SPEED = 200.0

@onready var animated_sprite = $AnimatedSprite2D

var init_scale = scale.x

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
		# if direction.x == -1 and direction.y == 0:
		# 	scale.x = - init_scale
		# else:
		# 	scale.x = init_scale
		look_at(position + direction)

	velocity = direction * SPEED

	if velocity.length() > 0:
		# If we are moving, play the walk cycle!
		animated_sprite.play("walking")
	else:
		# If we are standing still, play the idle animation (or stop)
		animated_sprite.play("idle") # Or animated_sprite.stop() if you don't have an idle animation yet!

	# 3. Tell Godot to actually move the body and handle bumping into counters!
	move_and_slide()


# We grab a reference to that Area2D node we just made
@onready var reach_area = $Reach

func _process(_delta: float) -> void:
	# "ui_accept" is the Spacebar or Enter key by default
	var overlapping_objects = reach_area.get_overlapping_areas() + reach_area.get_overlapping_bodies()

	#print(overlapping_objects)

	var ingredients: Array = overlapping_objects.filter(func(object): return object.is_in_group("ingredients"))
	var interactables: Array = overlapping_objects.filter(func(object): return object.is_in_group("interactables"))

	var looking_at = ingredients + interactables
	if looking_at.size() > 0:
		Inventory.looking_at = looking_at[0]
	else:
		Inventory.looking_at = null
	
	if Input.is_action_just_pressed("ui_accept") || Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		# print("Pressed Accept")
		#print(ingredients)
		#print(interactables)
		if ingredients.size() > 0:
			var object: Node2D = ingredients[0]

			if Inventory.holding != null:
				return

			Inventory.holding = object

			object.reparent(self )

			object.position = Vector2(24, 0)

			object.remove_from_group("ingredients")

			object.z_index = 5

			# object.queue_free()

		elif interactables.size() > 0:
			var object: Node2D = interactables[0]
			if object.item_id == "trash_can":
				#print("threw away " + Inventory.holding)
				if Inventory.holding == null:
					return
				Inventory.holding.queue_free()
				Inventory.holding = null
				return
				
			if object.item_id == "sink":
				if Inventory.holding == null:
					return
				if "washed" not in Inventory.holding.attributes:
					Inventory.holding.attributes.append("washed")
			
			if object.item_id == "cutting_board":
				if Inventory.holding == null:
					return
				if "diced" not in Inventory.holding.attributes:
					Inventory.holding.attributes.append("diced")

				
			if object.item_id == "market":
				if Inventory.holding == null:
					return
				Inventory.money += 5
				if "washed" in Inventory.holding.attributes:
					Inventory.money += 5
				if "diced" in Inventory.holding.attributes:
					Inventory.money += 5

				Inventory.holding.queue_free()
				Inventory.holding = null
				return

		else:
			return


	# if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
	# 	Inventory.holding = null
