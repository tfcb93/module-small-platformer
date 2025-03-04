extends Node2D;


func _ready() -> void:
	Globals.actual_level_tilemap = %Level;

	Events.win.connect(_on_win);
	Events.win.connect(_on_add_point);
	Events.kill_player.connect(_on_kill_player);
	Events.player_fell.connect(_on_player_fell);


func _on_win() -> void:
	print("congratulations, you win");
	Globals.is_game_finished = true;

func _on_add_point() -> void:
	Globals.player_points += 1;

func _on_kill_player() -> void:
	print("You died");
	Globals.is_game_over = true;
	Events.player_died.emit();

func _on_player_fell() -> void:
	print("You died");
	Globals.is_game_over = true;
	Events.player_died.emit();