extends Node2D

@export var template_item: Area2D
@export var spawn_time: float = 2.5

@onready var timer = $Timer

func _ready() -> void:
	timer.wait_time = spawn_time
	timer.start(spawn_time)
	# It autostarts, so it will spawn the first item automatically!

func _on_timer_timeout() -> void:
	var new_item = template_item.duplicate()
	new_item.global_position = global_position
	get_tree().current_scene.call_deferred("add_child", new_item)
	
	new_item.tree_exited.connect(_on_item_grabbed)

# We create a new function that runs ONLY when the player queue_free()'s the item
func _on_item_grabbed() -> void:
	print("The bush noticed the item was taken! Restarting the clock...")
	# Start the timer over again to grow a new one!
	timer.start()
