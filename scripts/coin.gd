extends Area2D;

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		%sound.play();

func _on_sound_finished() -> void:
		Events.add_point.emit();
		get_parent().call_deferred("remove_child", self);
		queue_free();
