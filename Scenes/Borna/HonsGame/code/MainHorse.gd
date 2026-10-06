extends Control

var bird := preload("res://Scenes/Borna/HonsGame/Bird.tscn")
var obstacle := preload("res://Scenes/Borna/HonsGame/Obstacle.tscn")
var obstacle_types:=[bird,obstacle]
var bird_height:=[370,420]
var can_spawn:=true
#vars
const hons_start_pos := Vector2i(310,423)


var speed: float=0.7


func _ready():
	new_game()
	$Timer.wait_time=5.0
	$Timer.start()


func new_game():
	$HonsChar.position=hons_start_pos
	
func _on_timer_timeout():
	game_won()
	print("win")
	queue_free()
func _process(delta):
	gen_obs()
	$Label.set_text(str(int($Timer.get_time_left())))


func gen_obs():
	
	if can_spawn:
		can_spawn=false
		var timer := randf_range(0.8,1.2)
		await get_tree().create_timer(timer).timeout
		
		var obs_type=obstacle_types[randi()%obstacle_types.size()]
		var obs = obs_type.instantiate() 
		add_child(obs)
		if obs_type==obstacle_types[0]:
			var y := randf_range(416,370)
			obs.position=Vector2(580,y)
			can_spawn=true
		else:
			obs.position=Vector2(580,394)
			can_spawn=true
		obs.body_entered.connect(hit_obs)
	

func hit_obs(body):
	if body.name=="HonsChar":
		print("hit")
		game_lost()
	
func game_won():	
	speed=0
	queue_free()
	
func game_lost():
	speed=0
	GlobalDistractionManager.set_distraction_active_state(false);
	$HonsChar.queue_free()
	$Timer.stop()
	queue_free()
	
	
	
