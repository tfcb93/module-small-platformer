extends Node2D;

func _ready() -> void:
    Events.play_sound.connect(_on_play_sound);

func _on_play_sound(sound_name: StringName) -> void:
    match sound_name:
        "coin":
            %coin.play();
        _:
            pass

