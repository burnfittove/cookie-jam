extends Node2D
var coffee := preload("res://Scenes/Borna/CoffeeGame/Coffee.tscn")
var loops := preload("res://Scenes/Borna/CoffeeGame/fruit_loop.tscn")
var sugar := preload("res://Scenes/Borna/CoffeeGame/Sugar.tscn")
var obstacle_types:=[
	coffee,
	loops,
	sugar
]
var can_spawn:=true
var winscore
#vars
const hons_start_pos := Vector2i(310,423)
@onready var score_label := $MarginContainer/HBoxContainer/ScoreLabel
@onready var label := $MarginContainer/HBoxContainer/Label
@onready var sfx := $SFX
@export var left_edge: Node2D
@export var right_edge: Node2D
@export var click_modifier := 2.0

var score := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_label.text = "Score: " + str(score)
	scale_with_difficulty()
	

func scale_with_difficulty() -> void:
	var node := get_parent();
	var controller := node as DistractionControllerBase;
	var diff: float = controller.get_difficulty(); 
	winscore = int(ceil(5 + diff / 2.0))
	label.text="Score " + str(winscore) + " to win"
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	gen_obs()

func gen_obs():
	
	if can_spawn:
		can_spawn=false
		var timer := randf_range(0.5,0.9)
		await get_tree().create_timer(timer).timeout
		
		var obs_type: PackedScene = obstacle_types[randi()%obstacle_types.size()]
		var obs := obs_type.instantiate()
		add_child(obs)

		var x := randf_range(left_edge.position.x, right_edge.position.x)
		obs.position=Vector2(x,-338.0)
		can_spawn=true
func reduce_score():
	if score>0:
		score -= 1
	score_label.text = "Score: " + str(score)
func add_score():
	score += 1
	score_label.text = "Score: " + str(score)
	sfx.play();
	if score>=winscore :
		game_won()
		
		
func game_won():
	GlobalSoundManager.play_mg_complete();
	GlobalDistractionManager.set_click_modifier(click_modifier)
	queue_free()
	
	