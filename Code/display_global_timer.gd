extends CanvasLayer

@onready var text_element: RichTextLabel = $MarginContainer/PanelContainer/RichTextLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var current_time := TimerManager.get_current_time();
	var minutes: int = floor(current_time / 60);
	var seconds_buffer: int = floor(current_time);
	var seconds: int = seconds_buffer % 60;
	text_element.text = "Time left: " + str(minutes) + ":" + (str(seconds) if seconds > 9 else "0" + str(seconds));
