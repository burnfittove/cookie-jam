class_name MapButton extends Button

@export var room: PackedScene
@export var room_type: RoomsEnum.Room_Type
var room_manager: RoomManager

func _ready() -> void:
	room_manager = get_node("/root/Main/RoomManager");

func _on_pressed() -> void:
	if (room_manager == null): 
		printerr(self.to_string() + " couldn't find a reference to the scene's room manager :(");
		return;
	
	room_manager.create_room(room, room_type);

func get_room_type() -> RoomsEnum.Room_Type:
	return room_type;
