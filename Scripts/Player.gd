extends CharacterBody2D

@export var move_speed : float = 50;
var animator : AnimatedSprite2D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sprite = $AnimatedSprite2D  # 等价于 get_node("AnimatedSprite2D")
	if sprite is AnimatedSprite2D:
		animator = sprite;
	pass # 替换为函数体。

# 固定每秒60次运行
func _physics_process(_delta: float) -> void:
	velocity = Input.get_vector("left","right","up","down") * move_speed;
	print(velocity);
	if velocity == Vector2.ZERO:
		animator.animation = "idle";
	else: 
		animator.animation = "run";
	# 玩家的移动
	move_and_slide();
	pass
