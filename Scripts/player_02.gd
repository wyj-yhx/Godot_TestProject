extends CharacterBody2D

@export var move_speed : float = 50

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# 是否结束游戏
var is_game_over : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # 替换为函数体。


# 固定每秒60次运行
func _physics_process(_delta: float) -> void:
	if not is_game_over:
		var is_sprinting = Input.is_action_pressed("sprint")
		var is_attack = Input.is_action_pressed("attack")
		var current_speed = move_speed
		if is_sprinting:
			current_speed *= 2
		velocity = Input.get_vector("left","right","up","down") * current_speed
		#print(velocity);
		animator.flip_h = velocity.x < 0
		if is_attack:
			animator.animation = "Attack01"
		else:
			if velocity == Vector2.ZERO:
				animator.animation = "Idle"
			else: 
				if is_sprinting:
					animator.animation = "Run"
				else:
					animator.animation = "Walk"
		# 玩家的移动
		move_and_slide()
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func game_over():
	pass
