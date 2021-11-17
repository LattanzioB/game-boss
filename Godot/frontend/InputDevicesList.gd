extends OptionButton

func _ready():
	var input_devices = AudioServer.capture_get_device_list()
	for i_d in input_devices:
		self.add_item(i_d)


func _on_InputDevicesList_item_selected(index):
	AudioServer.capture_set_device(AudioServer.capture_get_device_list()[index])
	print("Input device selected: " + AudioServer.capture_get_device_list()[index])
