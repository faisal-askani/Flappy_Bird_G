class_name SaveData extends Resource

@export var high_score : int = 0

#const SAVE_PATH : String = "res://Data/game_data.tres"
const SAVE_PATH : String = "user://game_data.tres"

func save() -> void:
	ResourceSaver.save(self, SAVE_PATH)
	print("Save file")

static func load_or_create() -> SaveData:
	var res:SaveData
	if FileAccess.file_exists(SAVE_PATH):
		res = load(SAVE_PATH) as SaveData
		print("Save file loaded")
	else:
		res = SaveData.new()
		print("Save file created")
	return res
