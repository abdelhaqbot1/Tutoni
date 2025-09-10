extends Node2D

var Game_end = false

func _process(delta):
	if Game_end == true:
		get_tree().paused = true
	check_end()
	pass
	
func check_end():
	if Game_end == false :
		var spots = $Spots.get_child_count()
		for i in $Spots.get_children():
			if i.in_spot:
				spots -= 1
		
		if spots == 0:
			$AcceptDialog.popup()
			Game_end = true
		
		pass
		



func _on_AcceptDialog_confirmed():
	#get_tree().quit()
	get_tree().change_scene_to_file("res://scenes/level2.tscn")
	get_tree().paused = false



func _on_AcceptDialog_popup_hide():
	get_tree().reload_current_scene()
	get_tree().paused = false
