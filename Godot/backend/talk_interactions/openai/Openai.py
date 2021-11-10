from godot import exposed, export
from godot import *
import os
import openai

@exposed
class Openai(Node):

	def get_response(self, prompt, engine="davinci", max_tokens=30):
		answer = openai.Completion.create(engine=engine,
							prompt=str(prompt),
							max_tokens=max_tokens,
							temperature=0.3,
							best_of=2,
							frequency_penalty=0.5,
							presence_penalty=0.3)
		
		return self.fix_answer(answer.choices[0].text)
		


	def fix_answer(self, input_text, previous_text):
		text =input_text.split('\n\n')
		
		print(text)
		if(len(text)==1 & len(text[0])<130):
			text = text[0]
			text = text + self.get_response(text)
		elif text[0]=='' & len(text[1])<130:
			text = text[1]
			text = text + self.get_response(text)
		elif text[0]=='' & len(text[1])>130:
			text = self.shrink_text(text[1])
		else:
			text = self.shrink_text(text[0])

		text = text.replace('\t','')
		print(text)
		return str(text)


#Se Limita la cantidad de caracteres de respuesta por limitante de TTS.
	def shrink_text(self,input_text):
		process_text = input_text
		while(len(process_text) > 130 & process_text.count('.') >= 1 ):
			process_text = process_text.rsplit('.', 1)[0]
		return process_text
		
		
	def _ready(self):
		openai.api_key = os.getenv("OPENAI_API_KEY")
