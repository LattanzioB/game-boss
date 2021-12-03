extends Control

onready var base_melody = $BaseMelody
onready var sentimen_chords = $SentimentChords

export var amor:AudioStream
export var empathy:AudioStream
export var hate:AudioStream

onready var sentimentDic = {
		"hate" : amor, 
		"love" : empathy, 
		"empathy" : hate
		}


onready var has_sentiment = false

# Called when the node enters the scene tree for the first time.
func _ready():
	base_melody.play(20.0)



func new_sentiment(sentiment):
	sentimen_chords.stream = sentimentDic.get(sentiment)
	has_sentiment = true

func _on_MelodyTimer_timeout():
	if has_sentiment:
		sentimen_chords.play(20)
		has_sentiment = false
	base_melody.play(20)
