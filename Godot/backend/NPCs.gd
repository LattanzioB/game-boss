extends Node

var sentiments
var key_list
var dialog_history

func _ready():
	sentiments = {"obnoxiously" : "miners fisherman", "lovingly"  : "town", "empathetically" : ""}
	dialog_history = ""

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
	return sentiment

func any_matches(input):
	var words = input.split(" ", true)
	var sentiment = ""
	for word in words:
		sentiment = matches(word)
		if (sentiment != ""):
			break
	return sentiment
