from godot import exposed, export
from godot import *
import os
import openai

@exposed
class Openai(Node):



	def _ready(self):
		
		openai.api_key = os.getenv("OPENAI_API_KEY")

		

	def get_response(self, prompt, engine="davinci", max_tokens=30):
		response = openai.Completion.create(engine=engine,
							prompt=str(prompt),
							max_tokens=max_tokens,
							temperature=0.3,
							best_of=1)
		
		return response.choices[0].text
