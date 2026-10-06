class_name MapButton extends NinePatchRect

@export var room: PackedScene
@export var room_type: Rooms.Room_Type
var room_manager: RoomManager

func _ready() -> void:
	room_manager = get_node("/root/IanTestScene/RoomManager");

func _on_pressed() -> void:
	if (room_manager == null): 
		printerr(self.to_string() + " couldn't find a reference to the scene's room manager :(");
		return;
	
	room_manager.create_room(room, room_type);

func get_room_type() -> Rooms.Room_Type:
	return room_type;
