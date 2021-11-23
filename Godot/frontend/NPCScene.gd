extends Node


onready var fire_place = $FirePlacePlayer
onready var journal = $Journal
onready var sound_control =$SoundControl 
onready var sfx = $SFx
onready var speechInt = $IntroductionPlayer
onready var chatBox = $Chatbox


onready var sceneIntroduction = ['2Lascomodidades.wav','3TuColaboracion.wav', '4YaQueJose.wav','5SiendoUnForestero.wav']
onready var sceneIntroductionText = ['Bienvenido a nuestro hogar', 'las comodidades no son muchas pero espero que te sientas como en casa',' Tu colaboracion nos ayuda mucho ', 'ya que José, el dueño de la fabrica para la que trabajo, no nos paga muy bien','Siendo un forastero quizas tengas algunas preguntas']
onready var introduction_counter = 4

onready var trigger_spawned = false

# Called when the node enters the scene tree for the first time.
func _ready():
	sfx.stream = load("res://assets/sfx/correct.mp3")
	sfx.stream.set_loop(false)
	speechInt.stream = load("res://assets/Speechs/1Bienvenido.wav")

func _on_SceneLoaded_timeout():
	speechInt.play()
	chatBox.spawn_npc_tile(sceneIntroductionText[0])
	sceneIntroductionText.remove(0)

func _on_IntroductionPlayer_finished():
	if introduction_counter > 0:
		speechInt.stream = load("res://assets/Speechs/" + sceneIntroduction[0])
		sceneIntroduction.remove(0)
		speechInt.play()
		chatBox.spawn_npc_tile(sceneIntroductionText[0])
		sceneIntroductionText.remove(0)
		introduction_counter -= 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !fire_place.is_playing():
		fire_place.play()

func _on_SpeechInteractions_speech_trigger(trigger_text):
	journal.show_trigger_text(trigger_text)
	sfx.play()
	if !trigger_spawned:
		$JournalTooltip.visible = true
		$HideTooltipTimer.start()
		trigger_spawned = true


func _on_FireFx_volume_control_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("FireFx"), value)


func _on_NPC_voice_volume_control_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Speech"), value)



func _on_ConfigurationGear_pressed():
	sound_control.visible = !sound_control.visible


func _on_Journal_on_button_pressed():
	journal.visible = !journal.visible

func _on_SwitchTooltipTimer_timeout():
	$JournalTooltip.visible = false

func _on_HideSettingsTooltip_timeout():
	$SettingsTooltip.visible = false

func _on_Journal_journal_complete():
	$EndGameTimer.start()

func _on_EndGameTimer_timeout():
	$GameOver.visible = true
