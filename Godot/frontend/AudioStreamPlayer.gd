extends AudioStreamPlayer

var file

func _ready():
	file = File.new()

func load_record(audio_file):
	if file.file_exists(audio_file):
		file.open(audio_file, file.READ)
		var buffer = file.get_buffer(file.get_len())
		stream = AudioStreamSample.new()
		stream.format = AudioStreamSample.FORMAT_16_BITS      
		stream.data = buffer
		stream.stereo = true
		file.close()
