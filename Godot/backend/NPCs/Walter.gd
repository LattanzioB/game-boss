extends "res://backend/NPCs/NPCs.gd"



func _ready():
	
	npc_name = "walter"
	sentiments = {
		"hate" : ["loneliness"], 
		"love" : ["son"], 
		"empathy" : ["workers"]
		}
	
	trigger_phrases = {
		#Frases del Journal
		#Un diccionario por cada trigger segun la emocion al respecto.
		"hate" : {"loneliness" : "Su soledad le genera tristeza."}, 
		"love" : {"son" : "Ama a su hijo."}, 
		"empathy": {"workers" : "Empatiza con sus empleados."}, 
		}
	
	triggers_synonyms ={
		#Diccionario de listas de sinonimos de triggers
		"son": ["family" ,"son", "firstborn", "child", "children", "father", "parent", "dad"], 
		"loneliness":["wife", "lonely", "loneliness", "solitude", "alone"], 
		"workers":["bob", "juan", "employees", "employee", "worker", "workers","staff"]
		}
	dialog_history = "1890 Walter Har\n\nWalter owns 3 factorys of train parts.\n\nWalter's got one son but lost his wife years ago.\n\nWalter works since he wakes up til he goes to sleep again, everyday.\n\nWalter's very self centered.\n\nWalter lives a stressfull life.\n\nWalter wishes he could spend more time with his son.\n\nWalter employs Jhon Smith and Bob Boyle and has empathy for his poor life-style."
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
