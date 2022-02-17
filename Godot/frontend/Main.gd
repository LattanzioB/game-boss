extends Node

onready var john_scene = $JohnScene
onready var first_time_john = true

onready var sage_scene = $SageScene

onready var bob_scene = $BobScene
#falso porque no hay introduccion todavia
onready var bob_journal_complete = false

onready var walter_scene = $WalterScene
#falso porque no hay introduccion todavia
onready var walter_journal_complete = false


onready var start_screen = $StartScreen

onready var gui = $GUI
onready var chatbox = $GUI/Chatbox
onready var journal = $GUI/Journal
onready var speechinter = $SpeechInteractions
onready var music_controler = $MusicControler

onready var current_scene = sage_scene

onready var trigger_spawned = false

onready var stages = {
	"introduction_first" : true,
	"introduction_second" : false,
	"journal_incompleted" : false,
	"journal_completed" : false,
	"shifter_not_received" : false,
	"shifter_received" : false,
	"game_finish" : false
}

onready var stage = "introduction_first"

func _ready():
	speechinter.set_chatbox(chatbox)
	

func set_language(lang):
	print("setting language")
	speechinter.set_language(lang)
	john_scene.set_language(lang)
	bob_scene.set_language(lang)
	sage_scene.set_language(lang)
	walter_scene.set_language(lang)
	
	
func next_stage():
	var posible_stage = stages.keys()[(stages.keys().find(stage) + 1)]
	if(stages.get(posible_stage)):
		stage = posible_stage
	return stage
	
func new_shifter():
	stages["shifter_received"] = true
	sage_scene.set_current_stage("shifter_received")
	stage = "shifter_received"
	sage_scene.delete_one_dialog()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func change_scene_to_walter():
	current_scene = walter_scene
	walter_scene.visible = true
	gui.visible = true
	speechinter.change_npc_player("WalterSpeech")
	speechinter.visible = true
	speechinter.set_active(true)
	walter_scene.set_gui(gui)
	walter_scene.set_speech_interactions(speechinter)
	walter_scene.load_scene()



func change_scene_to_bob():
	current_scene = bob_scene
	bob_scene.visible = true
	gui.visible = true
	speechinter.change_npc_player("BobSpeech")
	speechinter.visible = true
	speechinter.set_active(true)
	bob_scene.set_gui(gui)
	bob_scene.set_speech_interactions(speechinter)
	bob_scene.load_scene()



func change_scene_to_sage():
	current_scene = sage_scene
	sage_scene.visible = true
	gui.visible = true
	speechinter.change_npc_player("SageSpeech")
	speechinter.visible = true
	speechinter.set_active(true)
	sage_scene.set_gui(gui)
	sage_scene.set_speech_interactions(speechinter)
	sage_scene.load_scene()




func change_scene_to_johns():
	current_scene = john_scene
	john_scene.visible = true
	gui.visible = true
	speechinter.change_npc_player("JohnSpeech")
	speechinter.visible = true
	speechinter.set_active(true)
	john_scene.set_gui(gui)
	john_scene.set_speech_interactions(speechinter)
	john_scene.load_scene(first_time_john)
	first_time_john = false
	


func _on_StartScreen_intro_finish():
	start_screen.visible = false
	start_screen.disable()
	change_scene_to_sage()
	gui.map_button.visible = false


func _on_JohnScene_new_trigger_phrase(trigger, phrase, sentiment, npc_name):
	journal.show_tigger_phrase(trigger, phrase, npc_name)
	music_controler.new_sentiment(sentiment)

func _on_BobScene_new_trigger_phrase(trigger, phrase, sentiment, npc_name):
	journal.show_tigger_phrase(trigger, phrase, npc_name)
	music_controler.new_sentiment(sentiment)

func _on_WalterScene_new_trigger_phrase(trigger, phrase, sentiment, npc_name):
	journal.show_tigger_phrase(trigger, phrase, npc_name)
	music_controler.new_sentiment(sentiment)


func hide_scene():
	current_scene.visible = false
	gui.reset()


func _on_GUI_change_scene(scene):
	current_scene.hide_scene()
	hide_scene()
	gui.rec.visible = false
	match scene:
		"juan":
			change_scene_to_johns()
		"sage":
			change_scene_to_sage()
		"bob":
			change_scene_to_bob()
		"walter":
			change_scene_to_walter()

func set_bob_journal_complete():
	bob_journal_complete = true
	if(bob_journal_complete && walter_journal_complete):
		stages["journal_completed"] = true
		sage_scene.set_current_stage("journal_completed")

func set_walter_journal_complete():
	walter_journal_complete = true
	if(bob_journal_complete && walter_journal_complete):
		stages["journal_completed"] = true
		sage_scene.set_current_stage("journal_completed")
		sage_scene.delete_one_dialog()

func second_sage_scene():
	gui.map_button.visible = true
	john_scene.visible = false
	john_scene.hide_scene()
	gui.reset()
	change_scene_to_sage()

func start_scene_changer_timer():
	$ChangeSceneTimer.start()
	stages["introduction_second"] = true

func _on_SageScene_introduction_finished():
	gui.journal_button.visible = true
	sage_scene.visible = false
	sage_scene.hide_scene()
	gui.reset()
	change_scene_to_johns()


func _on_ChangeSceneTimer_timeout():
	second_sage_scene()


func _on_SpeechInteractions_new_speech():
	gui.thinking_bubble.visible = true


func _on_SpeechInteractions_finish_loading_speech():
	gui.thinking_bubble.visible = false


func _on_GUI_music_loop():
	music_controler.music_loop()
