extends Node

onready var john_back = $JohnBack
onready var john_scene = $JohnScene
onready var gui = $GUI
onready var chatbox = $GUI/Chatbox
onready var journal = $GUI/Journal
onready var speechinter = $SpeechInteractions


onready var trigger_spawned = false

func _ready():
	speechinter.set_chatbox(chatbox)
	speechinter.set_npc(john_back)
	john_scene.set_gui(gui)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func change_scene_to_johns():
	pass


func _on_JohnBack_trigger(trigger):
	journal.show_trigger_text(trigger)


func _on_JohnBack_new_trigger_phrase(trigger, phrase):
	journal.show_tigger_phrase(trigger, phrase)
