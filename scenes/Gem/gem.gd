extends Area2D
class_name  Gem

var SPEED: float = 250.0
signal game_over


func _ready() -> void:
	pass 

func _die() -> void:
	set_process(false)
	queue_free()

func _inc_speed() -> void:
	SPEED += 50

func _process(delta: float) -> void:
	position.y += SPEED * delta
	if position.y > get_viewport_rect().end.y:
		print("gem falls")
		game_over.emit()
		_die()

func _on_area_entered(area: Area2D) -> void:
	print("collision happened")
	_die()
