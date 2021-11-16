from godot import exposed, export, Node
import os
import openai

@exposed
class Openai(Node):
	def _ready(self):
		openai.api_key = os.getenv("OPENAI_API_KEY")

	def get_response(self, prompt, engine="davinci", max_tokens=40):
		answer = openai.Completion.create(engine=engine,
							prompt=str(prompt),
							max_tokens=max_tokens,
							temperature=0.3,
							best_of=2,
							frequency_penalty=0.5,
							presence_penalty=0.3)
		return self.fix_answer(answer.choices[0].text)

	def fix_answer(self, input_text):
		#Dividimos el input en sublistas segun cuantos saltos de linea haya
		text = input_text.split('\n\n')

		#Si hay un solo salto de linea
		if(len(text)==1):
			text = self.shrink_text(text[0])
		else:
			if text[0]=='':
				text = self.shrink_text(text[1])
			else:
				text = self.shrink_text(text[0])
			
		#text = text.replace('\t','')
		return str(text)

#Se Limita la cantidad de caracteres de respuesta por limitante de TTS.
	def shrink_text(self,input_text):
		process_text = input_text
		while(len(process_text) > 130 & process_text.count('.') >= 1 ):
			process_text = process_text.rsplit('.', 1)[0]
		return process_text
