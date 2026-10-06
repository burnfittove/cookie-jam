extends Control

@onready var first_child := get_child(0);
@export var active_room: RoomsEnum.Room_Type
var room_manager: RoomManager;

func _ready() -> void:
	var node := get_node("/root/Main/RoomManager");
	if (node != null): room_manager = node as RoomManager;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# If the distraction has a specific room assigned to it, it can't work unless that room is active
	var active := check_for_valid_activity();
	if (!active): set_children_state(false); return;
	else: set_children_state(true);
	
	if (!GlobalDistractionManager.get_distraction_active_state()): set_children_state(true);
	else: set_children_state(false);

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