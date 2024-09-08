extends Area2D

@onready var tutorial_label = $Label  # Cambia si la ruta del Label es diferente

# Función que se llama cuando el jugador entra en el área
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":  # Asegúrate de que 'Player' es el nombre de tu jugador
		tutorial_label.visible = true  # Muestra el tutorial cuando el jugador entra

# Función que se llama cuando el jugador sale del área
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		tutorial_label.visible = false  # Oculta el tutorial cuando el jugador sale
