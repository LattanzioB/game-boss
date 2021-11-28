extends Node

signal new_trigger_phrase

var dialog_history
var questions

var sentiments
var trigger_phrases
var triggers_synonyms
onready var triggers_found = []

var shifters
var shifters_received
var shifters_synonyms

var triggered_questions

func _ready():
	pass 

func get_shifters_synonyms():
	return self.shifters_synonyms

func set_shifters_synonyms(syno_dict):
	self.shifters_synonyms = syno_dict

func get_shifters():
	return self.shifters

func set_shifters(shifters):
	self.shifters = shifters

func get_shifters_received():
	return self.shifters_received

func set_shifters_received(newdict):
	self.shifters_received = newdict

func clean_shifters(shifters:Dictionary):
	var shifters_cleaned = shifters
	for key in shifters_cleaned:
		shifters_cleaned[key] = {
			"hate": [],
			"empathy": [],
			"love": []
		}
	return shifters_cleaned
	
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

func matches(input, text):
	#iterate trigger dict 
	for trigger in self.get_triggers_synonyms().keys():
		#iterate values of triggers synonyms
		for value in self.get_triggers_synonyms().get(trigger):
			#Si encuentra un valor igual al input
			if value == input:
				#si es la primera vez que encuentra el valor
				if !self.get_triggers_found().has(trigger):
					self.get_triggers_found().append(trigger)
					emit_signal("new_trigger_phrase", trigger, self.get_trigger_phrase(trigger, get_emotion_from_trigger(trigger)))
				else:
					look_for_shifters(text, trigger)

func get_emotion_from_trigger(trigger):
	var result_emotion 
	for emotion in self.get_sentiments(): 
		if self.get_sentiments()[emotion].has(trigger):
			result_emotion = emotion
	return result_emotion
#gets an array of words that may have a shifter.
func look_for_shifters(text, trigger):
	for word in text:
		for emotion in self.get_shifters().get(trigger):
			#por cada shifter que tenga
			for shifter in self.get_shifters().get(trigger).get(emotion):
				#si alguno de los sinonimos es igual al input y todavia no lo habia recibido
				if self.get_shifters_synonyms().get(shifter).has(word) && (!self.get_shifters_received().has(shifter)):
					print(word)
					#agregar shifter recibido 
					#limpiar el resto de las listas de shifters.
					self.set_shifter_as_received(trigger, emotion, shifter)
					#checkear si la cantidad de shifters recibidos es igual a la cantidad de 
					#shifters necesarios para cambiar
					if self.check_shifters_to_change(trigger, emotion) && (!self.get_sentiments().get(emotion).has(trigger)):
						#change emotion to trigger
						self.change_emotion_to_trigger(trigger, emotion)
						emit_signal('new_trigger_phrase', trigger, self.get_trigger_phrase(trigger, emotion))
				elif self.get_shifters_synonyms().get(shifter).has(word) && (self.get_shifters_received().has(shifter)):
					#shifter ya obtenido
					pass
					

func get_trigger_phrase(trigger, emotion):
	return self.get_trigger_phrases().get(emotion).get(trigger)
	
func get_trigger_phrases():
	return self.trigger_phrases

func change_emotion_to_trigger(trigger, emotion):
	for emo in self.get_sentiments():
		if emo == emotion:
			self.get_sentiments().get(emo).append(trigger) 
		else:
			self.get_sentiments().get(emo).erase(trigger)

func check_shifters_to_change(trigger, emotion):
	return len(self.get_shifters().get(trigger).get(emotion)) == len(self.get_shifters_received().get(trigger).get(emotion))


func set_shifter_as_received(trigger, emotion, shifter):
	for emot in self.get_shifters_received().get(trigger):
		if emot == emotion:
			self.get_shifters_received().get(trigger).get(emotion).append(shifter) 
		else:
			self.get_shifters_received().get(trigger).get(emot).clear()




func any_matches(input):
	var words = input.split(" ", true)
	for word in words:
		matches(word, words)

	
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
 
func set_triggers_synonyms(newsynonyms):
	self.triggers_synonyms = newsynonyms

func get_triggers_synonyms():
	return self.triggers_synonyms

func get_triggers_found():
	return self.triggers_found

func set_triggers_found(triggers:Array):
	self.triggers_found = triggers
