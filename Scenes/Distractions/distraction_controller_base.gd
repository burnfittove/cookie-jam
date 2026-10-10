class_name DistractionControllerBase extends Node

@export var interval := 30;
var interval_buffer;
@export var difficulty := 1;
@export var max_rand_num := 30;
@export var distraction_scene: PackedScene
@export var active_room: RoomsEnum.Room_Type
@export var check_for_active_room: bool
@export var check_for_other_distractions := true;
var attack_stored := false;
var is_distraction_active := false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interval_buffer = interval;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# If an attack is stored, start the distraction; please dont ask bro i dont gaf
	if (attack_stored 
		and RoomManager.current_room_type == active_room 
		and !GlobalDistractionManager.get_distraction_active_state()
		and check_for_active_room):
			start_game(); 
			return;
	
	# If the distraction has a specific room assigned to it, it can't work unless that room is active
	var active := check_for_visibility();
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
	
	# Check if another distraction is active, only if the controller is set to perform the check
	if (GlobalDistractionManager.get_distraction_active_state() and check_for_other_distractions): return;
	# Check if the player is in the active room, if not store the attack
	if (!check_for_active_room):
		start_game();
		print("1")
	if (RoomManager.current_room_type != active_room):
		attack_stored = true;
		print("2")
	elif (check_for_active_room):
		start_game();
		print("3");

func can_spawn(min_chance: int, max_chance: int) -> bool:
	var rng := RandomNumberGenerator.new();
	return difficulty > rng.randi_range(min_chance, max_chance);


func start_game() -> void:
	var scene_instance := distraction_scene.instantiate();
	add_child(scene_instance);
	GlobalDistractionManager.set_distraction_active_state(true);
	attack_stored = false;


func get_difficulty() -> int:
	return difficulty;


func check_for_visibility() -> bool:
	if (RoomManager == null): return false;
	if (RoomManager.current_room_type != active_room): return false;
	return true;


func set_children_state(active: bool) -> void:
	if (get_child_count() == 0): return;
	var child := get_child(0);
	if (child == null): return;
	if (active): child.show();
	else: child.hide();
