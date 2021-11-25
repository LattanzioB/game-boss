extends "res://backend/NPCs/NPCs.gd"



func _ready():
	sentiments = {"hate" : ["walter"], "love" : ["family", "fishing"], "empathy" : []}
	triggers_keywords ={"walter": ["boss","walter","Walter","factory owner"], "family":["family", "wife",'kids',"children","sons"], "fishing":["fish", "fishing"]}
	dialog_history = "1890\n\nJuan Smith is a railroad worker. Juan is 45 years old.\n\nFather of two boys James and Mark.\n\nJuan’s wife is called Mary, Mary is a house wife.\n\nJuan has barely enough money to feed his family every day.\n\nJuan works from 8am to 8pm, as employee in the assembly line, for a train parts factory.\n\nThe owner of the factory is called walter. walter lives in a big mansion outside the village. walter owns three other factories and walter is extremely rich. Juan loves fishing. Juan loves his family."
	questions = ["What bring's you to this small town?", "Do you like Fishing?"]
	#triggered_questions = 
