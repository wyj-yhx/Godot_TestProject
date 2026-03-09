extends Area2D

@export var slime_speed : float = -100;
var animator : AnimatedSprite2D;
var audioDeathSound : AudioStreamPlayer;
var is_dead : bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animator = $AnimatedSprite2D;
	audioDeathSound = $DeathSound;
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if not is_dead:
		position += Vector2(slime_speed, 0) * delta;
	if position.x < -260:
		queue_free();
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not is_dead:
		body.game_over();
		print("hit Player");
	pass # Replace with function body.


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		animator.play("death");
		audioDeathSound.play();
		is_dead = true;
		# 添加分数
		get_tree().current_scene.score += 1;
		# 删除子弹
		area.queue_free();
		await get_tree().create_timer(0.6).timeout;
		# 删除史莱姆
		queue_free();
	pass # Replace with function body.
