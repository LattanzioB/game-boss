extends Control

onready var stages = {
	"introduction_first" : [2,2],
	"introduction_second" : [6,6],
	"journal_incompleted" : [1,0],
	"journal_completed" : []
}
onready var stage = "introduction_first"


 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_orders():
	return stages.get(stage)

func next_stage():
	stage = stages.keys()[(stages.keys().find(stage) + 1)]
