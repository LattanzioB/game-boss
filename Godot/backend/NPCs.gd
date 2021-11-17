extends Node

signal trigger

var sentiments
var key_list
var dialog_history

func _ready():
	sentiments = {"hate" : "jose", "love" : "family, fishing", "empathy" : ""}
	dialog_history = "1890\n\nJohn Smith is a railroad worker. John is 45 years old.\n\nFather of two boys James and Mark.\n\nJohn’s wife is called Mary, Mary is a house wife.\n\nJohn has barely enough money to feed his family every day.\n\nJohn works from 8am to 8pm, as employee in the assembly line, for a train parts factory.\n\nThe owner of the factory is called Jacob. Jacob lives in a big mansion outside the village. Jacob owns three other factories and Jacob is extremely rich."

func get_dialog_history():
	return dialog_history


func add_npc_coment(coment):
	dialog_history = dialog_history + coment

func add_player_coment(coment):
	dialog_history = dialog_history + "\n\n" + coment

func matches(input):
	var sentiment = ""
	for key in sentiments.keys():
		if input in sentiments.get(key):
			sentiment = key
			print(input)
			emit_signal("trigger", input)
	return sentiment

func any_matches(input):
	var words = input.split(" ", true)
	var sentiment = ""
	var it = 0
	while(sentiment == "" && it < len(words)):
		sentiment = matches(words[it])
		it += 1
	return sentiment
