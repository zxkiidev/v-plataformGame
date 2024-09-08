extends Control

@onready var initial_segment : TextureRect = $BarInitial
@onready var middle_segment : TextureRect = $BarMiddle
@onready var final_segment : TextureRect = $BarFinal

var max_health = 100
var current_health = 100
var segment_width = 32  # Ancho de cada segmento

func _ready():
	update_health_bar()

func update_health_bar():
	# Calcula el número de segmentos visibles
	var segments_visible = int(float(current_health) / (float(max_health) / 3))
	
	# Ajusta la visibilidad y el tamaño de los segmentos según la salud
	initial_segment.visible = segments_visible > 0
	middle_segment.visible = segments_visible > 1
	final_segment.visible = segments_visible > 2
	
	if segments_visible > 0:
		initial_segment.size.x = segment_width
	if segments_visible > 1:
		middle_segment.size.x = segment_width
	if segments_visible > 2:
		final_segment.size.x = segment_width * (current_health % (max_health / 3)) / (max_health / 3)

func take_damage(amount: int):
	current_health -= amount
	current_health = clamp(current_health, 0, max_health)
	update_health_bar()

func heal(amount: int):
	current_health += amount
	current_health = clamp(current_health, 0, max_health)
	update_health_bar()
