extends VBoxContainer




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func spawn_chat_tile(text):
	var label = Label.new()
	label.set_text(text)
	self.add_child(label)
