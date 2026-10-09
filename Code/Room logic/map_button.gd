class_name MapButton extends Button

@export var room: PackedScene
@export var room_type: RoomsEnum.Room_Type

func _on_pressed() -> void:
	if (RoomManager == null): 
		printerr(self.to_string() + " couldn't find a reference to the scene's room manager :(");
		return;

	RoomManager.create_room(room, room_type);

func get_room_type() -> RoomsEnum.Room_Type:
	return room_type;
