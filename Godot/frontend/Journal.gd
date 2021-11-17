extends Sprite


onready var npc_name = $NPC_Name
onready var triggers_list = [$trigger_1, $trigger_2, $trigger_3]
onready var counter = $counter

onready var triggers:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	set_triggers({"family" : "Loves his family", "Jacob": "Hates Jacob", "Fishing": "Loves Fishing"})
	show_trigger_text("family")

#func _process(delta):
			

#Ej "family" : "Loves his family"
func set_triggers(dict):
	triggers = dict

func show_trigger_text(trigger):
	var trigger_to_use = get_free_trigger()
	trigger_to_use.set_text(triggers.get(trigger))
	counter_up()
	
	
func counter_up():
	counter.text[0] = str(int(counter.text[0]) + 1)

func get_free_trigger():
	var trigger = []
	var i = 0
	while (len(trigger) == 0 && i < len(triggers_list)):
		if len(triggers_list[i].text) == 0:
			trigger.append(triggers_list[i]) 
		i = i + 1
	#Agregar excepcpion no hay suficientes triggers en esta pagina.
	return trigger[0]
