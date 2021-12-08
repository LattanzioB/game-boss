extends Control

onready var stages = {
	"introduction_first" : [3,3],
	"introduction_second" : [5,5],
	"journal_incompleted" : [1,0],
	"journal_completed" : [6,5],
	"shifter_not_received" : [1,0],
	"shifter_received" :[3,3]
}
onready var stage = "introduction_first"


 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_orders():
	return stages.get(stage)

	
func set_current_stage(new_stage):
	stage = new_stage
