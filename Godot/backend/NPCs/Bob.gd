extends "res://backend/NPCs/NPCs.gd"



func _ready():
	
	npc_name = "bob"
	sentiments = {
		"hate" : ["loneliness"], 
		"love" : ["fishing"], 
		"empathy" : ["walter"]
		}
	
	trigger_phrases = {
		#Frases del Journal
		#Un diccionario por cada trigger segun la emocion al respecto.
		"hate" : {
			"loneliness" : "Su soledad le genera tristeza."
		}, 
		"love" : {
			"fishing" : "Le encata pescar." 
		}, 
		"empathy":{
			"walter" : "Empatiza con Walter."
		}
		}
	
	triggers_synonyms ={
		"walter": ["boss","walter","Walter","owner"], 
		"loneliness": ["family", "lonely", "loneliness", "solitude", "alone"], 
		"fishing":["fish", "fishing"]
		}
		
	triggered_answers = {
		"walter": {
			"hate" : "I hate Walter and his greed,",
			"empathy" : "I sympathise with Walter's life, he lives stressed by his work and after the death of his wife he has become very lonely."
		}
	}
	
	dialog_history = "1890.\n\nBob Boyle is a railroad worker. Bob is 40 years old. Bob is lonely because he doenst have a family.\n\nHe is friend with John Smith, they go fishing together.\n\nThe owner of the factory is called Walter. Walter lives in a big mansion outside the village. Walter owns three other factories and Walter is extremely rich.\n\nBob likes his work and has empathy for his boss, because of their lonelyness.\n\nBob knows that Walter has a rough life too."
	questions = ["Did you know that Walter is a lonely and stressed man?"]
	shifters =  {
		#Diccionario de triggers con diccionario de emociones con lista de shifters
		"walter": {
			"hate": ["greedy"],
			"empathy": ["lonely"]
		}
	}
	shifters_synonyms = {
		#Diccionario de listas de sinonimos de shifters
		"greedy": ["greedy", "mansion", "avaricious", "rich", "wealthy", "moneyed", "luxury", "luxurious", "luxuries"],
		"lonely": ["lonely", "loneliness", "solitude", "alone"],
	}
	shifters_received  = {
	#Diccionario de triggers con diccionario de emociones con listas de shifters recibidos de cada uno
			"walter": {
				"hate": [],
				"empathy": []
		}
	}
	#triggered_questions = 
