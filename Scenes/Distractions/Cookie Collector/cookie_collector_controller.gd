extends Control

@onready var first_child := get_child(0);
@export var active_room: RoomsEnum.Room_Type

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# If the distraction has a specific room assigned to it, it can't work unless that room is active
	var active := check_for_valid_activity();
	if (!active): set_children_state(false); return;
	else: set_children_state(true);
	
	if (!GlobalDistractionManager.get_distraction_active_state()): set_children_state(true);
	else: set_children_state(false);

func check_for_valid_activity() -> bool:
	if (RoomManager == null): return false;
	if (RoomManager.current_room_type != active_room): return false;
	return true;


func set_children_state(active: bool) -> void:
	if (get_child_count() == 0): return;
	for child in get_children():
		if (child == null): continue;
		if (active): child.show();
		else: child.hide();