extends Node2D

@export var item: Node2D
@export var spawn_position: Vector2
@export var spawn_time: float = 2.5

# 2. Grab a reference to the child Timer node
@onready var timer = $Timer

func _ready() -> void:
	# 3. Before the game starts, override the Timer's built-in time with our custom one!
	timer.wait_time = spawn_time

func _on_timer_timeout() -> void:
	# 1. Build the generic item
	var new_item = item.duplicate()
	
	# 2. Inject the custom data BEFORE adding it to the scene!
	new_item.global_position = spawn_position
	
	# 3. Drop it into the world
	get_tree().current_scene.call_deferred("add_child", new_item)
