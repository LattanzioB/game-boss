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
		self.local_model_en = 'backend/talk_interactions/tts/model_en.pt'
		self.local_model_es = 'backend/talk_interactions/tts/model_es.pt'
		self.local_file = ''
		self.example_batch = ["Hello, this is my factory. What brings you here? " ]

		self.en_model = 'https://models.silero.ai/models/tts/en/v2_lj.pt'
		self.es_model = 'https://models.silero.ai/models/tts/es/v2_tux.pt'
		
#		if not os.path.isfile(self.local_file):
#			torch.hub.download_url_to_file('https://models.silero.ai/models/tts/es/v2_tux.pt', self.local_file)
#
#		self.model = torch.package.PackageImporter(self.local_file).load_pickle("tts_models", "model")
#		self.model.to(self.device)
		self.model = ''



		#print("im there")
		#self.create_speech(self.example_batch)
		
	def load_model(self, lang):
		self.new_model = ''
		if (str(lang) == "es"):
			self.new_model = self.es_model
			self.local_file = self.local_model_es
		else:
			self.new_model = self.en_model
			self.local_file = self.local_model_en

		if not os.path.isfile(self.local_file):
			torch.hub.download_url_to_file(self.new_model, self.local_file)
	
		self.model = torch.package.PackageImporter(self.local_file).load_pickle("tts_models", "model")
		self.model.to(self.device)
		
		
	def create_speech(self, input_text, sample_rate=16000):
		string = str(input_text)
		audio_paths = self.model.save_wav(texts=string, sample_rate=sample_rate)

		return audio_paths[0]

	def _on_Button_pressed(self):
		self.create_speech(self.example_batch)
