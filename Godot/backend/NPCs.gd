extends Node

signal trigger

var sentiments
var key_list
var dialog_history

func _ready():
	sentiments = {"hate" : "Jacob", "love"  : "Family, Fishing", "empathy" : ""}
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
			emit_signal("trigger", input)
	return sentiment

func any_matches(input):
	var words = input.split(" ", true)
	var sentiment = ""
	for word in words:
		sentiment = matches(word)
		if (sentiment != ""):
			break
	return sentiment
