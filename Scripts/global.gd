extends Node

var score : int = 0
@onready var save_data_g : SaveData

func _ready():
	save_data_g = SaveData.load_or_create()
