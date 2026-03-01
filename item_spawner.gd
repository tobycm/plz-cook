extends Node2D

@export var item: Node2D
@export var spawn_position: Vector2

func _on_timer_timeout() -> void:
	# 1. Build the generic item
	var new_item = item.duplicate()
	
	# 2. Inject the custom data BEFORE adding it to the scene!
	new_item.global_position = spawn_position
	
	# 3. Drop it into the world
	get_tree().current_scene.call_deferred("add_child", new_item)
