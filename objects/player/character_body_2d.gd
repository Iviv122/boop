extends CharacterBody2D

# TODO: Cayote time

@export var SPEED : float = 150.0
@export var JUMP_VELOCITY : float = -300.0
@export var FALL_VELOCITY : float = 600

@export var DASH_DURATION : float = 0.4
@export var DASH_COOLDOWN : float = 2
@export var DASH_VELOCITY : float = 50

@export var PLAYER_HEIGHT : float = 64

@export var move_shader : Array[Node2D]
@export var dash_particles : GPUParticles2D
@export var sprite : Sprite2D
@export var move_offset : float = 30


var double_jump : bool = true

var offset : float = 0
var tween : Tween
var state: State
var direction : float
var dash_cooldown : float = 0
var dash_duration : float = 0
var dash_particle_material : ParticleProcessMaterial

func _ready() -> void:
	dash_particle_material = dash_particles.process_material as ParticleProcessMaterial
	#dash_particles.emitting = false

func handle_state() -> void:
	if dash_duration >0:
		state = State.Dash
	elif is_on_floor() and abs(velocity.x) > 0:
		state = State.Walk
		double_jump = true;
	elif is_on_floor() and abs(velocity.x) <= 0:
		state = State.Ground
		double_jump = true;
	elif velocity.y < 0:
		state = State.Jump
	else:
		state = State.Air

func dash() -> void:
	if dash_cooldown > 0:
		return;
	dash_cooldown = DASH_COOLDOWN
	dash_duration = DASH_DURATION

func jump() -> void:
	if state == State.Air:
		double_jump = false

	velocity.y = JUMP_VELOCITY

func can_jump() -> bool:
	if (state == State.Air || state == State.Jump) && !double_jump:
		return false
	if (state == State.Air || state == State.Jump) && double_jump:
		double_jump = false

	return true

func handle_durations(delta: float) -> void:
	dash_cooldown-=delta
	dash_cooldown = max(0,dash_cooldown-delta)

	dash_duration -= delta
	dash_duration = max(0,dash_duration-delta)

func _physics_process(delta: float) -> void:

	handle_state()
	if state == State.Air || State.Jump:
		velocity += get_gravity() * delta

	if state != State.Dash:
		direction = Input.get_axis("a", "d")
	if tween:
		tween.kill()
	tween = create_tween()

	tween.set_parallel(true)
	tween.tween_property(self,"offset",move_offset*direction,0.1)

	var scalex = clampf(1/abs(velocity.y/200),0.1,1)
	var scaley = clampf(1/abs(velocity.x/200),0.1,1)

	tween.tween_property(self,"global_scale:x",scalex,0.1)
	tween.tween_property(self,"global_scale:y",scaley,0.1)

	for i in move_shader:
		i.material.set_shader_parameter("offset",offset)

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
		dash()

	if Input.is_action_pressed("s"):
		velocity.y += FALL_VELOCITY

	if Input.is_action_just_pressed("jump") and can_jump():
		jump()

	handle_durations(delta)
	#dash_particles.emitting = dash_duration > 0
	move_and_slide()

enum State{
	Ground,
	Dash,
	Walk,
	Jump,
	Air,
}
