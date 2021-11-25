extends Control


onready var chatbox = $Chatbox
onready var sound_control = $SoundControl
onready var journal = $Journal
onready var rec = $Rec
onready var sfx = $SFx


# Called when the node enters the scene tree for the first time.
func _ready():
	sfx.stream = load("res://assets/sfx/correct.mp3")
	sfx.stream.set_loop(false)


func _process(delta):
	if Input.is_action_just_released("talk") && (!rec.visible):
		rec.visible = true
	elif Input.is_action_just_released("talk") && (rec.visible):
		rec.visible = false



func chatbox_spawn_npc_tile(text):
	chatbox.spawn_npc_tile(text)



func _on_ConfigurationGear_pressed():
	sound_control.visible = !sound_control.visible



func _on_FireFx_volume_control_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("FireFx"), value)


func _on_NPC_voice_volume_control_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Speech"), value)

func _on_Journal_on_button_pressed():
	journal.visible = !journal.visible


func _on_Journal_journal_complete():
	$GameOver.visible = true


func _on_Journal_new_trigger_found(trigger):
	journal.show_trigger_text(trigger)
	sfx.play()



func _on_Journal_on_button_mouse_entered():
	$JournalTooltip.visible = true


func _on_Journal_on_button_mouse_exited():
	$JournalTooltip.visible = false


func _on_ConfigurationGear_mouse_entered():
	$SettingsTooltip.visible = true


func _on_ConfigurationGear_mouse_exited():
	$SettingsTooltip.visible = false
