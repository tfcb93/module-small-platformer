extends CharacterBody2D;

class_name Player;

const SPEED: float = 200.0;
const JUMP_VELOCITY: float = -350.0;

func _ready() -> void:
	Events.player_died.connect(_on_player_died);
	Events.win.connect(_on_player_win);

func _physics_process(delta: float) -> void:

	if (not Globals.is_game_finished and not Globals.is_game_over):
		
		if (not is_on_floor()):
			velocity += get_gravity() * delta;

			if (position.y > get_viewport_rect().size.y):
				Events.player_fell.emit();

		if (Input.is_action_just_pressed("jump") and is_on_floor()):
			velocity.y = JUMP_VELOCITY;
			Events.play_sound.emit("jump");
			%animations.play("jump");

		var direction: float = Input.get_axis("left", "right");
		if (position.x < 0): position.x = 0;
		if (position.x > Globals.actual_level_size.x): position.x = Globals.actual_level_size.x;
		if (direction) :
			velocity.x = direction * SPEED;
			%animations.play("run");
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED);
			%animations.play("idle");

		move_and_slide();


func _on_player_died() -> void:
	var parent: Node2D = get_parent();
	var camera: Camera2D = %camera;
	camera.position = position;
	remove_child(camera);
	parent.add_child(camera);
	parent.call_deferred("remove_child",self);
	queue_free();

func _on_player_win() -> void:
	%animations.frame = 0;
	%animations.stop();