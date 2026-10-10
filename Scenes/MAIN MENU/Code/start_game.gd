extends Button

@export var next_scene: PackedScene;
@onready var root = $"../../../../"

func _on_pressed() -> void:
	var result = await SceneTransition.fade_in();
	if result:
		var scene := next_scene.instantiate();
		get_tree().root.add_child(scene);
		SceneTransition.fade_out(false);
		root.queue_free();
