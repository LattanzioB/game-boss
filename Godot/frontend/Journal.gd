extends Sprite

signal journal_complete
signal new_trigger_found
signal first_trigger

onready var npc_name_label = $NPC_Name
onready var triggers_list = [$trigger_1, $trigger_2, $trigger_3]
onready var counter = $counter

onready var first_trigger = false

onready var page_counter = 0

onready var counters = {
		"juan": '0/3',
		"walter": '0/3',
		"bob": '0/3'
}

onready var triggers = {
	"juan": {
		
	},
	"walter": {
		
	},
	"bob":{
		
	},
}

# Called when the node enters the scene tree for the first time.
func _ready():
	show_page("juan")
	

func show_page(npc_name):
	npc_name_label.text = npc_name
	counter.text = counters.get(npc_name)
	free_labels()
	var i = 0
	for trigger in triggers.get(npc_name):
		triggers_list[i].text = triggers.get(npc_name).get(trigger)
		i += 1


func free_labels():
	for label in triggers_list:
		label.text = ''

func next_page():
	page_counter = (page_counter + 1) % (len(triggers.keys()))
	show_page(triggers.keys()[page_counter])
	
	
func counter_up(npc_name):
	counters[npc_name][0] = str(int(counters.get(npc_name)[0]) + 1)
	if(counters.get(npc_name)[0]) == (counters.get(npc_name)[-1]):
		emit_signal("journal_complete", npc_name)

func show_tigger_phrase(trigger, phrase, npc_name):
	if triggers.get(npc_name).keys().has(trigger):
		triggers[npc_name][trigger] = phrase
		show_page(npc_name)
		page_counter = triggers.keys().find(npc_name)
	else:
		triggers[npc_name][trigger] = phrase
		show_trigger_text(trigger, npc_name)

	

func show_trigger_text(trigger, npc_name):
	emit_signal("new_trigger_found", trigger)
	show_page(npc_name)
	page_counter = triggers.keys().find(npc_name)
	counter_up(npc_name)
	if !first_trigger:
		emit_signal("first_trigger")
		first_trigger = true


func _on_Area2D_input_event(viewport, event, shape_idx):
	if(event is InputEventMouseButton && event.pressed):
		next_page()
