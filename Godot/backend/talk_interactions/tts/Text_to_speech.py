from godot import exposed, export, signal
from godot import *
import torch
import os



@exposed
class Text_to_speech(Node):

	
	def _ready(self):
		print("im here")
		self.device = torch.device('cpu')
		torch.set_num_threads(8)
		self.local_file = 'backend/talk_interactions/tts/model.pt'
		self.example_batch = ['Siendo un forastero quizas tengas algunas preguntas.']

		if not os.path.isfile(self.local_file):
			torch.hub.download_url_to_file('https://models.silero.ai/models/tts/es/v2_tux.pt',
										   self.local_file)
	

		self.model = torch.package.PackageImporter(self.local_file).load_pickle("tts_models", "model")
		self.model.to(self.device)
		print("im there")
		self.create_speech(self.example_batch)
		
		
	def create_speech(self, input_text, sample_rate=16000):
		string = str(input_text)
		audio_paths = self.model.save_wav(texts=string, sample_rate=sample_rate)

		return audio_paths[0]

	def _on_Button_pressed(self):
		self.create_speech(self.example_batch)
