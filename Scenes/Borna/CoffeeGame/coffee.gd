extends Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

	position.y+=1.6
	#get_parent().speed
	if position.y>=750:
		get_parent().reduce_score()
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("CharacterBody2D detected!")
		get_parent().add_score()
		queue_free()
		
	
