extends Node

onready var john_scene = $JohnScene
onready var first_time_john = true

onready var sage_scene = $SageScene
onready var first_time_sage = true

onready var bob_scene = $BobScene
#falso porque no hay introduccion todavia
onready var first_time_bob = false

onready var walter_scene = $WalterScene
#falso porque no hay introduccion todavia
onready var first_time_walter = false


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
	"journal_completed" : false
}

onready var stage = "introduction_first"

func _ready():
	speechinter.set_chatbox(chatbox)

func next_stage():
	var posible_stage = stages.keys()[(stages.keys().find(stage) + 1)]
	if(stages.get(posible_stage)):
		stage = posible_stage
	return stage
	
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
	walter_scene.load_scene(first_time_walter)
	first_time_bob = false


func change_scene_to_bob():
	current_scene = bob_scene
	bob_scene.visible = true
	gui.visible = true
	speechinter.change_npc_player("BobSpeech")
	speechinter.visible = true
	speechinter.set_active(true)
	bob_scene.set_gui(gui)
	bob_scene.set_speech_interactions(speechinter)
	bob_scene.load_scene(first_time_bob)
	first_time_bob = false


func change_scene_to_sage():
	current_scene = sage_scene
	sage_scene.visible = true
	gui.visible = true
	speechinter.change_npc_player("SageSpeech")
	speechinter.visible = true
	speechinter.set_active(true)
	sage_scene.set_gui(gui)
	sage_scene.set_speech_interactions(speechinter)
	sage_scene.load_scene(first_time_sage)
	first_time_sage = false



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
