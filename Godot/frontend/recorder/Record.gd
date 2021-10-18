extends Control

var effect
var recording
signal file_saved

func _ready():
	var index = AudioServer.get_bus_index("Record")
	effect = AudioServer.get_bus_effect(index, 0)
	AudioServer.capture_set_device(AudioServer.capture_get_device_list()[3])
	
	
func _on_RecordButton_pressed():
	if effect.is_recording_active():
		recording = effect.get_recording()
		effect.set_recording_active(false)
		$RecordButton.text = "Record"
	
	else:
		effect.set_recording_active(true)
		$RecordButton.text = "Stop"


func _on_PlayButton_pressed():
	$AudioStreamPlayer.stream = recording
	$AudioStreamPlayer.play()


func _on_SaveButton_pressed():
	var save_path = "res://backend/talk_interactions/stt/record.wav"
	recording.save_to_wav(save_path)
	emit_signal("file_saved")
