extends Node

signal trigger

var sentiments
var dialog_history
var questions
var triggers_keywords

var triggered_questions

func _ready():
	pass 


func set_sentiments(newsentiments:Dictionary):
	self.sentiments = newsentiments

func get_sentiments():
	return self.sentiments

func set_dialog_history(newdialog):
	self.dialog_history = newdialog

func get_dialog_history():
	return self.dialog_history

func set_questions(newquestions):
	self.questions = newquestions

func get_questions():
	return self.questions
 
func set_triggers_keywords(newkeywords):
	self.triggers_keywords = newkeywords

func get_triggers_keywords():
	return self.triggers_keywords

func get_question():
	var question = ""
	if len(self.questions) > 0:
		question = questions[0]
		self.questions.remove(0)
	return question


func add_npc_coment(coment):
	self.dialog_history = dialog_history + coment

func add_player_coment(coment):
	self.dialog_history = dialog_history + "\n\n" + coment

func matches(input):
	var sentiment = ""
	for key in self.get_triggers_keywords().keys():
		for value in self.get_triggers_keywords().get(key):
			if value == input:
				print(input)
				sentiment = "found"
				emit_signal("trigger", key)
				self.remove_sentiment_value(key)
	return sentiment
	
func remove_sentiment_value(value):
	for key in self.get_sentiments():
		if self.get_sentiments().get(key).find(value) != -1:
			self.get_sentiments().get(key).erase(value)

func any_matches(input):
	var words = input.split(" ", true)
	var sentiment = ""
	var it = 0
	while(sentiment == "" && it < len(words)):
		sentiment = matches(words[it])
		it += 1
	return sentiment
