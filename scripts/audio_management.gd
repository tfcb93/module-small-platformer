extends Node2D;

func _ready() -> void:
    Events.play_sound.connect(_on_play_sound);

func _on_play_sound(sound_name: StringName) -> void:
    match sound_name:
        "coin":
            %coin.play();
        "kill":
            %kill.play();
        "hit":
            %hit.play();
        "jump":
            %jump.play();
        _:
            pass

