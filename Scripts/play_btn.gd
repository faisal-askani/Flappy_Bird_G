extends TextureButton


func _on_pressed():
	scene_manager.on_scene_change(scene_manager.MAIN_SCENE)

