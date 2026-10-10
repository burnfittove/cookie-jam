extends Node

@export var start_room: PackedScene
@export var map: Map;
@export var current_room_type: RoomsEnum.Room_Type

# Called when the node enters the scene tree for the first time.
# func _ready() -> void:
	# Instantiate the first room
	# create_room(start_room, RoomsEnum.Room_Type.MAIN)	# HARD CODED ROOM TYPE; COULD CAUSE PROBLEMS


func create_room(room: PackedScene, room_type: RoomsEnum.Room_Type) -> void:
	# If the room_type is the current room, return
	if current_room_type == room_type: return;
	# Destroy a room if it currently exists
	if (get_child_count() > 0): get_child(0).queue_free();
	# Set current room
	current_room_type = room_type;
	print(current_room_type);
	# Create the scene
	var child := room.instantiate();
	add_child(child);
