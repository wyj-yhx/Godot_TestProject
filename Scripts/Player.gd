extends CharacterBody2D

@export var move_speed : float = 50;
var animator : AnimatedSprite2D;
#创建子弹的场景
@export var bullet_scene : PackedScene;

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
	if not is_game_over:
		is_game_over = true;
		animator.play("game_over");
		get_tree().current_scene.show_game_over();
		# 异步运行，等待倒计时结束
		await get_tree().create_timer(3).timeout;
		# 重启游戏
		get_tree().reload_current_scene();


func _on_fire() -> void:
	if is_game_over: 
		return;
	#将子弹的场景进行实例化
	var bullet_node = bullet_scene.instantiate();
	#设置子弹的位置为玩家的位置
	bullet_node.position = position + Vector2(6, 6);
	#将子弹场景设置为当前场景的子节点
	get_tree().current_scene.add_child(bullet_node);
	pass # Replace with function body.
