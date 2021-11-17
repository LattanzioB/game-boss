extends Node


onready var fire_place = $FirePlacePlayer
onready var journal = $Journal

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !fire_place.is_playing():
		fire_place.play()

func _on_SpeechInteractions_speech_trigger(trigger_text):
	journal.show_trigger_text(trigger_text)
