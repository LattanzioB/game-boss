extends Node

signal trigger

var sentiments:Dictionary
var key_list
var dialog_history
var questions
var triggered_questions
func _ready():
	sentiments = {"hate" : ["jose"], "love" : ["family", "fishing"], "empathy" : []}
	dialog_history = "1890\n\nJuan Smith is a railroad worker. Juan is 45 years old.\n\nFather of two boys James and Mark.\n\nJuan’s wife is called Mary, Mary is a house wife.\n\nJuan has barely enough money to feed his family every day.\n\nJuan works from 8am to 8pm, as employee in the assembly line, for a train parts factory.\n\nThe owner of the factory is called Jose. Jose lives in a big mansion outside the village. Jose owns three other factories and Jose is extremely rich."
	questions = ["What bring's you to this small town?", "Do you like Fishing?"]
	#triggered_questions = 


func get_question():
	var question = ""
	if len(questions) > 0:
		question = questions[0]
		questions.remove(0)
	return question

func get_dialog_history():
	return dialog_history

func add_npc_coment(coment):
	dialog_history = dialog_history + coment

func add_player_coment(coment):
	dialog_history = dialog_history + "\n\n" + coment

func matches(input):
	var sentiment = ""
	for key in sentiments.keys():
		for value in sentiments.get(key):
			if value == input:
				sentiment = key
				print(input)
				emit_signal("trigger", input)
				sentiments.get(key).erase(input)
	return sentiment

func any_matches(input):
	var words = input.split(" ", true)
	var sentiment = ""
	var it = 0
	while(sentiment == "" && it < len(words)):
		sentiment = matches(words[it])
		it += 1
	return sentiment
