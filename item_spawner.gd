extends Node2D

@export var item: Node2D

func _on_timer_timeout() -> void:
	# 1. Build the generic item
	var new_item = item.duplicate()
	
	var random_x = randf_range(0, 1152)
	var random_y = randf_range(0, 648)

	# 2. Inject the custom data BEFORE adding it to the scene!
	new_item.global_position = global_position + Vector2(random_x, random_y)
	
	# 3. Drop it into the world
	get_tree().current_scene.call_deferred("add_child", new_item)
