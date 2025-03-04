extends Node2D;


func _on_area_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		Events.win.emit();