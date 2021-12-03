extends "res://backend/NPCs/NPCs.gd"



func _ready():
	
	npc_name = "Bob"
	sentiments = {
		"hate" : [], 
		"love" : [], 
		"empathy" : []
		}
	
	trigger_phrases = {
		#Frases del Journal
		#Un diccionario por cada trigger segun la emocion al respecto.
		"hate" : {}, 
		"love" : {}, 
		"empathy":{}, 
		}
	
	triggers_synonyms ={
		#Diccionario de listas de sinonimos de triggers
		}
	dialog_history = ""
	questions = []
	shifters =  {
		#Diccionario de triggers con diccionario de emociones con lista de shifters
	}
	shifters_synonyms = {
		#Diccionario de listas de sinonimos de shifters
	}
	shifters_received  = {
	#Diccionario de triggers con diccionario de emociones con listas de shifters recibidos de cada uno
	}
	#triggered_questions = 
