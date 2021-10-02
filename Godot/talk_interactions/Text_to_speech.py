from godot import exposed, export, Button
from godot import *
import torch
import os



@exposed
class text_to_speech(Control):

	
	def _ready(self):
		print("im here")
		self.device = torch.device('cpu')
		torch.set_num_threads(8)
		self.local_file = 'model.pt'
		self.example_batch = ['Calor seguro, inmediato y eficiente, ',
				  'El sistema infrarrojo utiliza cuarzos con resistencia en su interior, ',
				  'brindando mayor efectividad']

		if not os.path.isfile(self.local_file):
			torch.hub.download_url_to_file('https://models.silero.ai/models/tts/es/v2_tux.pt',
										   self.local_file)


		self.model = torch.package.PackageImporter(self.local_file).load_pickle("tts_models", "model")
		self.model.to(self.device)
		self.create_speech(self.example_batch)


	def create_speech(self, input_text, sample_rate=16000):
		#Cambiar nombre de cada archivo despues de guardarlo para evitar sobreescritura.
		#i = 0
		#for string in input_text:
			# path=f'test_{str(i).zfill(3)}.wav'
		audio_paths = self.model.save_wav(texts=input_text, sample_rate=sample_rate)
		#	i = i + 1
		print(audio_paths)









