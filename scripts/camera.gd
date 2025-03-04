extends Camera2D;

func _ready() -> void:

	Events.update_camera_limits.connect(_on_update_camera_limits);

	_on_update_camera_limits();

func _on_update_camera_limits() -> void:
	if (Globals.actual_level_size == Vector2i.ZERO):
		limit_right = get_viewport_rect().size.x as int;
		limit_bottom = get_viewport_rect().size.y as int;
	else:
		limit_right = Globals.actual_level_size.x;
		limit_bottom = Globals.actual_level_size.y;

	limit_left = 0;
	limit_top = 0;