extends Area2D

const SPEED: float = 550

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	var movement: float = Input.get_axis("move_left", "move_right")
	position.x += SPEED * movement * delta
	position.x = clampf(
		position.x,
		get_viewport_rect().position.x,
		get_viewport_rect().end.x
	)
