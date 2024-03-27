extends CanvasLayer


const MAIN_SCENE = "res://Scenes/main.tscn"

@onready var _anim = $anim
@onready var _flash_frame = $ColorRect


func on_scene_change(scene):
	_flash_frame.show()
	
	_anim.play("fade_in")
	await _anim.animation_finished
	
	get_tree().change_scene_to_file(scene)
	
	_anim.play("fade_out")
	await _anim.animation_finished
	
	_flash_frame.hide()


#	get_tree().get_root().connect("size_changed", _on_viewport_resized)
#	_resize_to_window()
#func _resize_to_window():
#	prints("Resizing window:", get_tree().get_root().size)
#	var window_size = get_tree().get_root().size
#	_flash_frame.set_size(window_size)
#
#func _on_viewport_resized():
#	_resize_to_window()
