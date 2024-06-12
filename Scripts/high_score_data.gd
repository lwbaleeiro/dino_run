class_name HighScoreData extends Resource

const FILE_PATH = "user://game-data-high-score.tres"

@export var high_score = {
	"name": "",
	"score": "",
	"date": ""
}

func _ready():
	var high_score_data = HighScoreData.new()
	high_score_data.show_high_score()

func save() -> void:
	ResourceSaver.save(self, FILE_PATH)
	
func get_high_score():
	var data = load_data()
	return data
	print("Name: %s" % data.high_score["name"])
	print("Score: %s" % data.high_score["score"])

static func load_data() -> HighScoreData:
	var saved_data: HighScoreData
	if FileAccess.file_exists(FILE_PATH):
		saved_data = load(FILE_PATH) as HighScoreData
	else:
		saved_data = HighScoreData.new()
	return saved_data
	
