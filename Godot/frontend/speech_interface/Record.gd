extends Control

var effect
var recording
signal file_saved

func _ready():
	var index = AudioServer.get_bus_index("Record")
	effect = AudioServer.get_bus_effect(index, 0)

func _on_RecordButton_pressed():
	if effect.is_recording_active():
		stop_recording()
		$RecordButton.text = "Record"
	else:
		start_recording()
		$RecordButton.text = "Stop"

func _on_PlayButton_pressed():
	$AudioStreamPlayer.stream = recording
	$AudioStreamPlayer.play()

func _on_SaveButton_pressed():
	save_to_wav()

func start_recording():
	effect.set_recording_active(true)
	
func stop_recording():
	recording = effect.get_recording()
	effect.set_recording_active(false)

func save_to_wav():
	var save_path = "res://backend/talk_interactions/stt/record.wav"
	recording.save_to_wav(save_path)
	emit_signal("file_saved")
	print("File saved in: " + save_path)

func _on_InputDevicesList_item_selected(index):
	AudioServer.capture_set_device(AudioServer.capture_get_device_list()[index])
	print("Input device selected: " + AudioServer.capture_get_device_list()[index])

func _on_ToggleRecordButton_pressed():
	if effect.is_recording_active():
		stop_recording()
	else:
		start_recording()
