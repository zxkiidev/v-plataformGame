extends Camera2D
func _ready() -> void:
	top_level = true
	global_position.y = 202

func _process(delta: float) -> void:
	global_position.x = get_parent().global_position.x
