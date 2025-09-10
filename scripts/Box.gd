extends CharacterBody2D

@onready var ray = $RayCast2D

var inputs = {
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT
}

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
		return true
	return false
