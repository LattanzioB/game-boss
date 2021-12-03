extends MarginContainer

onready var container = $ScrollContainer/Container
var last_label:Label

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("clear"):
		clear()
		
func clear():
	for n in container.get_children():
		container.remove_child(n)
		n.queue_free()

func spawn_player_tile(text):
	if (last_label != null && last_label.get_align() == 0):
		container.remove_child(last_label)
	last_label = spawn_tile(text)

func spawn_npc_tile(text):
	last_label = spawn_tile(text, 2, Color(1,0,0)) #2 = right, 1.0.0 = red

func spawn_tile(text, align=0, color=Color( 0.13, 0.55, 0.13, 1 )): #0 = left, color = forestgreen
	var label = Label.new()
	label.set_autowrap(true)
	label.anchor_left = 0
	label.anchor_right = 1
	label.set_align(align)
	label.set_text(text)
	label.set_theme(load("res://assets/fonts/Pixel font.tres"))
	label.add_color_override("font_color", color)
	container.add_child(label)
	return label
