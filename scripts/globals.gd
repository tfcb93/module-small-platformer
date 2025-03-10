extends Node;

var actual_level_tilemap: TileMapLayer:
	get:
		return actual_level_tilemap;
	set(tilemap):
		actual_level_tilemap = tilemap;
		actual_level_size = tilemap.get_used_rect().size * tilemap.rendering_quadrant_size;

var actual_level_size: Vector2i = Vector2i.ZERO:
	get:
		return actual_level_size;
	set(size):
		actual_level_size = size;
		Events.update_camera_limits.emit();

var player_score: int = 0:
	get:
		return player_score;
	set(score):
		player_score = score;
		Events.update_score.emit();

var is_game_finished: bool = false;

var is_game_over: bool = false;
