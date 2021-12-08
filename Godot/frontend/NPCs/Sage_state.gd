extends Control

onready var stages = {
	"introduction_first" : [3,3],
	"introduction_second" : [4,4],
	"journal_incompleted" : [1,0],
	"journal_completed" : []
}
onready var stage = "introduction_first"


 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_orders():
	return stages.get(stage)

	
func set_current_stage(new_stage):
	stage = new_stage
