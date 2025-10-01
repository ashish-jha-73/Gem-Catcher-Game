extends Node2D

const EXPLODE = preload("res://assets/explode.wav")
const GEM = preload("res://scenes/Gem/gem.tscn")
var ctr = 0
const DEC: float = 0.25
const MINIMUM_SPEED_OF_GEM: float = 0.25
const AFTER_ITER = 10
const MARGIN = 25
var score: int = 0;
@onready var score_sound: AudioStreamPlayer2D = $Score_Sound
@onready var score_label: Label = $Score_Label
signal increase_speed

func _ready() -> void:
	randomize()
	_spawn_gem()

func _process(delta: float) -> void:
	pass


func _spawn_gem() -> void:
	var ng: Gem = GEM.instantiate()
	var x_pos: float = randi_range(get_viewport_rect().position.x + MARGIN, get_viewport_rect().end.x - MARGIN)
	ng.position = Vector2(x_pos, -20.0)
	ng.game_over.connect(_on_game_over)
	increase_speed.connect(ng._inc_speed)
	add_child(ng)

func _stop_all() -> void:
	$Sound.stop()
	$Sound.stream = EXPLODE
	$Sound.play()
	$Timer.stop()
	$Paddle.set_process(false)
	for child in get_children():
		if child is Gem:
			child.set_process(false)

func _on_game_over() -> void:
	_stop_all()

func _on_timer_timeout() -> void:
	ctr += 1
	if ctr % AFTER_ITER == 0 and ctr != 0 and $Timer.get_wait_time() - DEC >= MINIMUM_SPEED_OF_GEM:
		$Timer.set_wait_time($Timer.get_wait_time() - DEC)
	_spawn_gem()


func _on_paddle_area_entered(area: Area2D) -> void:
	score += 1
	if score % 20 == 0:
		increase_speed.emit()
	score_label.text = "%03d" % score
	if score_sound.playing == false:
		score_sound.position = area.position
		score_sound.play()
