extends CanvasLayer

@onready var label_score = $VBoxContainer/HBoxContainer3/HBoxContainer/LabelScore
@onready var label_best_score = $VBoxContainer/HBoxContainer3/HBoxContainer2/LabelBestScore

func score_updated(score: float):
	label_score.text = str(score)

func best_score_updated(score: String):
	label_best_score.text = score
