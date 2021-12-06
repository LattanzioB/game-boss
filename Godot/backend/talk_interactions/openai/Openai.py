from godot import exposed, export, Node, ConfigFile
import os
import openai

@exposed
class Openai(Node):
	def _ready(self):
		openai.api_key = os.getenv("OPENAI_API_KEY")

	def set_api_key(self, api_key):
		openai.api_key = api_key

	def get_response(self, prompt, engine="davinci", max_tokens=40):
		try:
			answer = openai.Completion.create(engine=engine,
							prompt=str(prompt),
							max_tokens=max_tokens,
							temperature=0.3,
							best_of=2,
							#decrece la chance de que el modelo repita
							frequency_penalty=1.3,
							#aumenta la chance de que el modelo improvise
							presence_penalty=0.4)
			return self.fix_answer(answer.choices[0].text)
		except:
			return "99999"

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
