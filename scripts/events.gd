extends Node;

signal update_camera_limits();

signal play_sound(sound_name: StringName);

signal show_message();
signal hide_message();
signal show_menu();
signal hide_menu();

signal kill_player();
signal player_fell();
signal player_died();
signal stop_enemies();

signal add_point();
signal update_score();

signal win();

signal restart_game();