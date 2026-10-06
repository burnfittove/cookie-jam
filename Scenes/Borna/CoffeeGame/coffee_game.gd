extends Node2D
var coffee := preload("res://Scenes/Borna/CoffeeGame/Coffee.tscn")
var obstacle_types:=[coffee]
var can_spawn:=true
#vars
const hons_start_pos := Vector2i(310,423)
@onready var score_label := $ScoreLabel

var score := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_label.text = "Score: " + str(score)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	gen_obs()

func gen_obs():
	
	if can_spawn:
		can_spawn=false
		var timer = randf_range(0.5,0.9)
		await get_tree().create_timer(timer).timeout
		
		#var obs_type=obstacle_types[randi()%obstacle_types.size()]
		var obs = coffee.instantiate()
		add_child(obs)

		var x= randf_range(424,710)
		obs.position=Vector2(x,135)
		can_spawn=true
func reduce_score():
	if score>0:
		score -= 1
	score_label.text = "Score: " + str(score)
func add_score():
	score += 1
	score_label.text = "Score: " + str(score)
	if score==5 :
		game_won()
		
		
func game_won():
	queue_free()
	
