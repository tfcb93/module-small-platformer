extends CanvasLayer;

func _ready() -> void:
    if (OS.has_feature("web")):
        %quit.visible = false;
    
    %big_message.visible = false;
    %simple_menu.visible = false;
    %player_score.visible = false;

    Events.start_game.connect(_on_start_game);
    Events.show_message.connect(_on_show_message);
    Events.hide_message.connect(_on_hide_message);
    Events.show_menu.connect(_on_show_menu);
    Events.hide_menu.connect(_on_hide_menu);
    Events.update_score.connect(_on_update_score);

func _on_restart_pressed() -> void:
    Events.restart_game.emit();

func _on_quit_pressed() -> void:
    get_tree().quit();

func _on_update_score() -> void:
    %player_score.text = "Score: %d" % Globals.player_score;

func _on_show_message(message: StringName) -> void:
    %big_message.text = message;
    %big_message.visible = true;

func _on_hide_message() -> void:
    %big_message.visible = false;

func _on_show_menu() -> void:
    %simple_menu.visible = true;

func _on_hide_menu() -> void:
    %simple_menu.visible = false;

func _on_start_game() -> void:
    %player_score.visible = true;