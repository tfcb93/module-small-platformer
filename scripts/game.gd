extends Node2D;

@onready var level_instance: PackedScene = preload("res://scenes/level.tscn");

var actual_level: Node;

func _ready() -> void:

	create_level();

	Events.win.connect(_on_win);
	Events.add_point.connect(_on_add_point);
	Events.kill_player.connect(_on_kill_player);
	Events.player_fell.connect(_on_player_fell);
	Events.restart_game.connect(_on_restart_game);

func create_level() -> void:
	actual_level = level_instance.instantiate();
	Globals.actual_level_tilemap = actual_level;
	add_child(actual_level);
	move_child(actual_level, 1);

func _on_win() -> void:
	Globals.is_game_finished = true;
	Events.show_message.emit("You Win!");
	Events.show_menu.emit();

func _on_add_point(value: int = 1) -> void:
	Globals.player_score += value;

func _on_kill_player() -> void:
	Events.show_message.emit("Game Over");
	Events.show_menu.emit();
	Globals.is_game_over = true;
	Events.player_died.emit();
	Events.stop_enemies.emit();

func _on_player_fell() -> void:
	Events.show_message.emit("Game Over");
	Events.show_menu.emit();
	Globals.is_game_over = true;
	Events.player_died.emit();
	Events.stop_enemies.emit();

func _on_restart_game() -> void:
	Events.hide_message.emit();
	Events.hide_menu.emit();
	Globals.is_game_finished = false;
	Globals.is_game_over = false;
	Globals.player_score = 0;

	remove_child(actual_level);
	actual_level.call_deferred("queue_free");
	create_level();