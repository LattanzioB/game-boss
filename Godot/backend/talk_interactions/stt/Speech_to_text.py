from godot import exposed, export
from godot import *
import torch
from omegaconf import OmegaConf
from utils import (read_batch,
				   prepare_model_input)
				

@exposed
class Speech_to_text(Control):

	def _ready(self):
		device = torch.device('cpu')   # you can use any pytorch device
		models = OmegaConf.load('models.yml')
		
		model, decoder, utils = torch.hub.load(repo_or_dir='snakers4/silero-models',
									   model='silero_stt',
									   language='es', # also available 'de', 'es'
									   device=device)
		
		self.wav_to_text()
		
	def wav_to_text(self, f='test-16000-4t.wav'):
		batch = read_batch([f])
		input = prepare_model_input(batch, device=device)
		output = model(input)
		return decoder(output[0].cpu())

