extends CharacterBody3D

const SPEED = 5.0

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var currentPosition: Vector3i 
@onready var destinationPosition: Vector3
@onready var navigation_region_3d = get_tree().get_first_node_in_group("nav")

func _physics_process(delta: float) -> void:
	navigation_agent_3d.target_position = destinationPosition
	var next_position = navigation_agent_3d.get_next_path_position()
	var direction = global_position.direction_to(next_position)
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	if (navigation_agent_3d.is_navigation_finished()):
		velocity = Vector3i(0, 0, 0);
