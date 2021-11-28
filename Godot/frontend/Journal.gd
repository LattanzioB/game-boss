extends Sprite

signal journal_complete
signal new_trigger_found

onready var npc_name = $NPC_Name
onready var triggers_list = [$trigger_1, $trigger_2, $trigger_3]
onready var counter = $counter

onready var triggers:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func show_tigger_phrase(trigger, phrase):
	if triggers.keys().has(trigger):
		change_label_text(trigger, phrase)
		triggers[trigger] = phrase
	else:
		triggers[trigger] = phrase
		show_trigger_text(trigger)

func change_label_text(trigger, phrase):
	for label in triggers_list:
		if label.text == triggers[trigger]:
			label.text = phrase
	

func show_trigger_text(trigger):
	if triggers.has(trigger): 
		emit_signal("new_trigger_found", trigger)
		var trigger_to_use = get_free_trigger_label()
		var trigger_text = self.triggers.get(trigger)
		trigger_to_use.set_text(trigger_text)
		counter_up()
		if(counter.text[0] == "3"):
			emit_signal("journal_complete")
	

func counter_up():
	counter.text[0] = str(int(counter.text[0]) + 1)

func get_free_trigger_label():
	var trigger = []
	var i = 0
	while (len(trigger) == 0 && i < len(triggers_list)):
		if len(triggers_list[i].text) == 0:
			trigger.append(triggers_list[i]) 
		i = i + 1
	#Agregar excepcpion no hay suficientes triggers en esta pagina.
	return trigger[0]


func _on_Close_pressed():
	self.visible = false
