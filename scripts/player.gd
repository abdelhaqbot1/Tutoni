extends CharacterBody2D

@onready var ray = $RayCast2D

var inputs = {
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT
}

func _process(delta):
	$AnimationPlayer.play("idle")
	pass


func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)
		if event.is_action_pressed("restart"):
			get_tree().reload_current_scene()
		if event.is_action_pressed("restar_all"):
			get_tree().change_scene_to_file("res://scenes/level.tscn")
	pass

func move(dir):
	var vetor_pos = inputs[dir] * 16
	ray.target_position = vetor_pos
	ray.force_raycast_update()
	$Tween.interpolate_property(
		self, "position", position,
		position + vetor_pos, 0.1,
		Tween.TRANS_SINE,
		Tween.EASE_IN
	)
	
	
	if !ray.is_colliding():
		$Tween.start()
		#position += vetor_pos
	else:
		var collider = ray.get_collider()
		if collider.is_in_group("Box"):
			if collider.move(dir):
				position += vetor_pos
