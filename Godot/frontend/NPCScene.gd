extends Node


onready var fire_place = $FirePlacePlayer
onready var journal = $Journal
onready var sound_control =$SoundControl 

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !fire_place.is_playing():
		fire_place.play()

func _on_SpeechInteractions_speech_trigger(trigger_text):
	journal.show_trigger_text(trigger_text)


func _on_FireFx_volume_control_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("FireFx"), value)


func _on_NPC_voice_volume_control_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Speech"), value)



func _on_ConfigurationGear_pressed():
	sound_control.visible = !sound_control.visible


func _on_Journal_on_button_pressed():
	journal.visible = !journal.visible
