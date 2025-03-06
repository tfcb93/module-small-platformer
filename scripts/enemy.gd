extends CharacterBody2D;

class_name Enemy;

const SPEED: float = 100.0;

var direction: float = 0.0;
@onready var last_x_position: float = position.x;

func _ready() -> void:
	%animation.play("default");
	direction = choose_direction();
	change_direction();

	Events.stop_enemies.connect(_on_stop_enemies);


func _physics_process(delta: float) -> void:
	if (not Globals.is_game_finished and not Globals.is_game_over):
		if (not is_on_floor()):
			velocity += get_gravity() * delta;

			if (position.y > get_viewport_rect().size.y):
				delete_enemy();

		if (position.x < 0): position.x = 0;
		if (position.x > Globals.actual_level_size.x): position.x = Globals.actual_level_size.x;
		if (direction):
			velocity.x = direction * SPEED;

		move_and_slide();
		if (position.x == last_x_position):
			direction *= -1.0;
			change_direction();
		else:
			last_x_position = position.x;
	
func choose_direction() -> float:
	var new_direction: Array[float] = [1.0, -1.0];
	new_direction.shuffle();
	return new_direction.front();

func change_direction() -> void:
	if direction > 0.0:
		$animation.flip_h = true;
	else:
		$animation.flip_h = false;

func hit_another_enemy() -> void:
	direction *= -1.0;
	change_direction();

func delete_enemy() -> void:
	get_parent().call_deferred("remove_child", self);
	queue_free();

func _on_head_area_body_entered(body: Node2D) -> void:
	if (body is Player and not Globals.is_game_over):
		Events.add_point.emit(5);
		Events.play_sound.emit("kill");
		delete_enemy();

func _on_bottom_area_body_entered(body: Node2D) -> void:
	if (body is Player):
		Events.kill_player.emit();
		Events.play_sound.emit("hit");
	if (body is Enemy):
		hit_another_enemy();

func _on_stop_enemies() -> void:
	%animation.frame = 0;
	%animation.stop();