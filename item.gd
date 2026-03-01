extends Area2D

# 1. Export the data slots
@export var item_id: String
@export var item_texture: Texture2D
@export var texture_scale: Vector2 = Vector2(1, 1)

@export var attributes: Array[String] = []

# 2. Grab the Sprite node
@onready var sprite = $Sprite2D

func _ready() -> void:
	# 3. When this spawns, instantly slap the texture onto the sprite!
	if item_texture != null:
		sprite.texture = item_texture

	sprite.scale = texture_scale
