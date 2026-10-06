class_name DistractionControllerBase extends Node

@export var interval := 30;
var interval_buffer;
@export var difficulty := 1;
@export var max_rand_num := 30;
@export var distraction_scene: PackedScene
@export var active_room: RoomsEnum.Room_Type
var is_distraction_active := false;
var room_manager;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interval_buffer = interval;
	var node := get_node("/root/Main/RoomManager");
	if (node != null): room_manager = node as RoomManager;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# If the distraction has a specific room assigned to it, it can't work unless that room is active
	var active := check_for_valid_activity();
	if (!active): set_children_state(false);
	else: set_children_state(true);
	
	# If the number of children is greater than zero, the distraction is active
	is_distraction_active = get_child_count() > 0;
	if (is_distraction_active): return;
	
	# Decrease interval buffer
	interval_buffer -= delta;
	if interval_buffer > 0.0: return;
	
	# Reset the timer for future use
	interval_buffer = interval;
	
	# Check for spawn chance
	#if !can_spawn(0, max_rand_num): return;	# Will be added later
	start_game();

func can_spawn(min: int, max: int) -> bool:
	var rng := RandomNumberGenerator.new();
	return difficulty > rng.randi_range(min, max);


func start_game() -> void:
	var scene_instance := distraction_scene.instantiate();
	add_child(scene_instance);
	GlobalDistractionManager.set_distraction_active_state(true);


func get_difficulty() -> int:
	return difficulty;


func check_for_valid_activity() -> bool:
	if (room_manager == null): return false;
	if (room_manager.current_room_type != active_room): return false;
	return true;


func set_children_state(active: bool) -> void:
	if (get_child_count() == 0): return;
	var child := get_child(0);
	if (child == null): return;
	if (active): child.show();
	else: child.hide();
