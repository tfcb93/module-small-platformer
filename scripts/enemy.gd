extends Node2D;

const SPEED: float = 200.0;

func _on_head_area_body_entered(body: Node2D) -> void:
	if (body.name == "Player" and not Globals.is_game_over):
		get_parent().call_deferred("remove_child",self);
		queue_free();


func _on_bottom_area_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		Events.kill_player.emit();
