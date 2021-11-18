extends VBoxContainer

var last_label:Label

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("clear"):
		for n in self.get_children():
			self.remove_child(n)
			n.queue_free()

func spawn_player_tile(text):
	if (last_label != null && last_label.get_align() == 0):
		self.remove_child(last_label)
	last_label = spawn_tile(text)

func spawn_npc_tile(text):
	last_label = spawn_tile(text, 2, Color(1,0,0)) #2 = right, 1.0.0 = red

func spawn_tile(text, align=0, color=Color(0,1,0)): #0 = left, 0.1.0 = green
	var label = Label.new()
	label.set_align(align)
	label.set_text(text)
	label.set_theme(load("res://assets/fonts/Pixel font.tres"))
	label.add_color_override("font_color", color)
	self.add_child(label)
	return label
