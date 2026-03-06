extends CharacterBody2D

@export var move_speed : float = 50;
var animator : AnimatedSprite2D;
# 是否结束游戏
var is_game_over : bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sprite = $AnimatedSprite2D  # 等价于 get_node("AnimatedSprite2D")
	if sprite is AnimatedSprite2D:
		animator = sprite;
	pass # 替换为函数体。

# 固定每秒60次运行
func _physics_process(_delta: float) -> void:
	if not is_game_over:
		velocity = Input.get_vector("left","right","up","down") * move_speed;
		#print(velocity);
		if velocity == Vector2.ZERO:
			animator.animation = "idle";
		else: 
			animator.animation = "run";
		# 玩家的移动
		move_and_slide();
		pass

func game_over():
	is_game_over = true;
	animator.play("game_over");
	# 异步运行，等待倒计时结束
	await get_tree().create_timer(3).timeout;
	# 重启游戏
	get_tree().reload_current_scene();
