extends CharacterBody2D
class_name PlayerBody

# TODO: wall jump with shape checker instead of raycast

@export var SPEED : float = 150.0
@export var JUMP_VELOCITY : float = -300.0
@export var FALL_VELOCITY : float = 600
@export var COYOTE_TIME: float = 0.5

@export var DASH_DURATION : float = 0.4
@export var DASH_COOLDOWN : float = 2
@export var DASH_VELOCITY : float = 50

@export var PLAYER_HEIGHT : float = 64

@export var move_shader : Array[Node2D]
@export var dash_particles : GPUParticles2D
@export var eyes : Array[Sprite2D]
@export var sprite : Sprite2D
@export var move_offset : float = 30

@export var death_channel : PlayerChannel

var double_jump : bool = true

var offset : float = 0
var tween : Tween
var state: State
var direction : float
var dash_cooldown : float = 0
var dash_duration : float = 0
var dash_particle_material : ParticleProcessMaterial
var coyote_duration : float = 0

signal died
signal spawned

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		die()

func _ready() -> void:
	dash_particle_material = dash_particles.process_material as ParticleProcessMaterial
	await get_tree().physics_frame
	spawned.emit()
	death_channel.created(self)

func handle_state() -> void:
	if dash_duration > 0:
		state = State.Dash
	elif is_on_floor():
		state = State.Ground
		coyote_duration = COYOTE_TIME
		double_jump = true
	elif is_on_wall():
		state = State.Wall
		double_jump = true
	else:
		state = State.Air

func die() -> void:
	death_channel.die(self)
	died.emit()
	queue_free()

func can_dash() -> bool:
	return !(dash_cooldown > 0 || is_zero_approx(direction))

func reset_dash_cooldown() -> void:
	dash_cooldown = 0

func dash() -> void:
	dash_cooldown = DASH_COOLDOWN
	dash_duration = DASH_DURATION

func grant_extra_double_jump() -> void:
	double_jump = true

func jump() -> void:
	velocity.y = JUMP_VELOCITY

func can_jump() -> bool:
	if coyote_duration > 0:
		coyote_duration = 0
		return true
	if state == State.Air:
		if double_jump:
			double_jump = false
			return true
		else:
			return false

	return true

func handle_durations(delta: float) -> void:
	dash_cooldown-=delta
	dash_cooldown = max(0,dash_cooldown-delta)

	dash_duration -= delta
	dash_duration = max(0,dash_duration-delta)

	coyote_duration -= delta
	coyote_duration = max(0,coyote_duration-delta)

func _physics_process(delta: float) -> void:

	handle_state()
	if state == State.Air:
		velocity += get_gravity() * delta

	if state != State.Dash:
		direction = Input.get_axis("a", "d")
	if tween:
		tween.kill()
	tween = create_tween()

	tween.set_parallel(true)

	tween.tween_property(self,"offset",move_offset*direction,0.1)

	var scalex = clampf(1/abs(velocity.y/250),0.7,1)
	var scaley = clampf(1/abs(velocity.x/250),0.7,1)

	tween.tween_property(self,"global_scale:x",scalex,0.1)
	tween.tween_property(self,"global_scale:y",scaley,0.1)

	for i in move_shader:
		i.material.set_shader_parameter("offset",offset)


	tween.tween_property(eyes[0],"position:x",move_offset*direction-16,0.1)
	tween.tween_property(eyes[1],"position:x",move_offset*direction+16,0.1)

	var eyemul = (int)(velocity.y > 50)*1+(int)(velocity.y < 0)*-1

	tween.tween_property(eyes[0],"position:y",16*eyemul,0.1)
	tween.tween_property(eyes[1],"position:y",16*eyemul,0.1)

	dash_particle_material.scale_3d_max = Vector3(global_scale.x,global_scale.y,1)
	dash_particle_material.scale_3d_min = Vector3(global_scale.x,global_scale.y,1)

	if state != State.Dash:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		velocity.x += direction * DASH_VELOCITY

	if Input.is_action_pressed("shift"):
		if can_dash():
			dash()

	if Input.is_action_pressed("s"):
		velocity.y += FALL_VELOCITY

	if Input.is_action_just_pressed("jump"):
		if can_jump():
			jump()

	handle_durations(delta)
	move_and_slide()

enum State{
	Ground,
	Wall,
	Dash,
	Air,
}
