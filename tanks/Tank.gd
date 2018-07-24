extends KinematicBody2D

signal shoot (bullet, _position, _direction)
signal health_changed
signal has_died

export (PackedScene) var Bullet
export (int) var speed
export (float) var rotation_speed
export (float) var gun_cooldown
export (int) var health

var velocity = Vector2()
var can_shoot = true
var is_alive = true

func shoot():
	if can_shoot:
		can_shoot = false
		$GunTimer.start()
		var bullet_direction = Vector2(1, 0).rotated($Turret.global_rotation)
		emit_signal('shoot', Bullet, $Turret/Muzzle.global_position, bullet_direction) 

func _ready():
	$GunTimer.wait_time = gun_cooldown
	
func control(delta):
	if Input.is_action_pressed('click'):
		shoot()
	
func _physics_process(delta):
	if not is_alive:
		return
	control(delta)
	move_and_slide(velocity)

func _on_GunTimer_timeout():
	can_
