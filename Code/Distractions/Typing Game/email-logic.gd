extends Control

@export var words: Array[String]
var chosen_words: Array[String]
@export var duration: float = 20.0;
var duration_buffer: float;
@onready var v_box_controller := $PanelContainer/MarginContainer/VSplitContainer/VBoxContainer;
@onready var progress := $PanelContainer/MarginContainer/VSplitContainer/ProgressBar

var active_element;
var current_character_index := -1;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set this minigame's values to scale with the difficulty
	scale_with_difficulty();
	duration_buffer = duration;
	progress.max_value = duration;
	progress.value = duration;
	var rng := RandomNumberGenerator.new();
	# Get random words
	for n in 3:
		var word := words[rng.randi_range(0, words.size() - 1)].to_lower();
		chosen_words.append(word);
	
	# Assign words to elements
	for index in v_box_controller.get_child_count():
		var rich_text: RichTextLabel = v_box_controller.get_child(index);
		rich_text.text = chosen_words[index];


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	duration_buffer -= delta;
	progress.value = duration_buffer;
	if duration_buffer < 0.0: queue_free();


func _unhandled_key_input(event: InputEvent) -> void:
	if event is not InputEventKey and not event.is_pressed(): return;
	# Get the typed key as a string
	var keyboard_event := event as InputEventKey;
	var key_typed := PackedByteArray([keyboard_event.unicode]).get_string_from_utf8();
	
	if (active_element == null):
		# Get the active element
		get_new_active_word(key_typed);
	else:
		# Check if the typed key is the same as the next character
		var prompt = active_element.get_prompt();
		var next_character = prompt.substr(current_character_index, 1);
		if (key_typed == next_character):
			current_character_index += 1;	# If it is, move to the next letter
			active_element.set_next_character(current_character_index)
			if (current_character_index == prompt.length()):	# Reset values if the word has been typed
				current_character_index = -1;
				active_element.queue_free()
				active_element = null;


func get_new_active_word(typed_character: String):
	# Check all rich text nodes to see if one of them begins with the typed letter; if so, its the new active word
	if (v_box_controller == null): return;
	for child: RichTextLabel in v_box_controller.get_children():
		var prompt = child.get_prompt();
		var next_character = prompt.substr(0, 1);
		if next_character != typed_character: return;
		active_element = child;
		current_character_index = 1;
		active_element.set_next_character(current_character_index)



func scale_with_difficulty() -> void:
	var node := get_parent();
	var controller := node as DistractionControllerBase;
	var diff: float = controller.get_difficulty();
	var new_duration := -5 * log(diff + 1.0) + duration;	# If time needs to be extended, increase duration; if the curve needs to be deeper, increase the first number
	duration = new_duration;
	print(duration);


func _on_v_box_container_completed() -> void:
	queue_free();
