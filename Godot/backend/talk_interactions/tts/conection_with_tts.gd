extends Node


onready var tts = $Tts

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_Button_pressed():
	print(tts)
	#.create_speech()
