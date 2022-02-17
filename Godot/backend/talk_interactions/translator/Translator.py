from godot import exposed, export
from godot import *
from googletrans import Translator

@exposed
class TranslatorHelper(Node):

	def _ready(self):
		self.translator = Translator()

	
	def translate_to_english(self, textInput):
		return self.translator.translate(textInput).text

	def translate_to_spanish(self, textInput):
		return self.translator.translate(textInput, dest='es').text
