extends Node

var is_any_distraction_active := false;
var is_email_hard_mode := false
var time_decrease_modifier := 1.0;
var warning_active := false;
var click_modifier := 1.0;
var min_click_mod := .05;
var max_click_mod := 1.5;


func _process(delta: float) -> void:
	update_click_modifier(delta / 20);


### ================== ###
### DISTRACTION ACTIVE ###
### ================== ###
func set_distraction_active_state(is_distraction_active: bool) -> void:
	is_any_distraction_active = is_distraction_active;
	
func get_distraction_active_state() -> bool:
	return is_any_distraction_active;


### ================ ###
### EMAIL DIFFICULTY ###
### ================ ###
func set_email_difficulty(is_hard_mode: bool) -> void:
	is_email_hard_mode = is_hard_mode;
	
func get_email_difficulty() -> bool:
	return is_email_hard_mode;


### ================== ###
### TIME DECREASE BUFF ###
### ================== ###
func set_time_decrease_modifier(modifier: float) -> void:
	time_decrease_modifier = modifier;

func get_time_decrease_modifier() -> float:
	return time_decrease_modifier;


func set_warning(active: bool):
	warning_active = active;
### ======================= ###
### CLICK MODIFIER DECREASE ###
### ======================= ###
func update_click_modifier(delta: float) -> void:
	if click_modifier < min_click_mod:
		click_modifier = min_click_mod;
		return;
	click_modifier -= delta;
	
func set_click_modifier(value: float):
	if value > max_click_mod:
		value = max_click_mod
	click_modifier = value;
	
func get_click_modifier() -> float:
	return click_modifier;
