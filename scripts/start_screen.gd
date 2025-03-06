extends Node2D;

func _ready() -> void:
    if (OS.has_feature("web")):
        %quit.visible = false;

func _on_quit_pressed() -> void:
    get_tree().quit();

func _on_start_game_pressed() -> void:
    Events.start_game.emit();
