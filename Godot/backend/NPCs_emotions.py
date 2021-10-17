from godot import exposed, export
from godot import *
import shlex


@exposed
class emotions(Control):

	def _ready(self):
		self.sentiments = {"anger" : "miners fisherman",
						   "love"  : "town"}

	def any_matches(self, input):
		#Probar python split
		words = shlex.split(input)
		sentiment = ""
		for word in words:
			sentiment = self.matches(word)
			if (sentiment != ""):
				break
		return sentiment


	def matches(self, input):
		sentiment = ""
		for key, value in self.sentiments.items():
			if input in value:
				sentiment = key
		return sentiment




