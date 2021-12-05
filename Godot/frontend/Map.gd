extends Node

signal change_scene

onready var jhon_label = $"Jhon Label"
onready var sage_label = $"Sage Label"
onready var factory_label = $"Factory Label"
onready var bob_label = $"Bob Label"

func _ready():
	pass


func change_scene(scene):
	emit_signal("change_scene", scene)


func _on_Jhons_House_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		_instantiate_confirmation_text_box("¿Ir a la casa de Juan?", "juan")

func _on_Factory_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		_instantiate_confirmation_text_box("¿Ir a la fábrica?", "walter")

func _on_Sages_Woods_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		_instantiate_confirmation_text_box("¿Ir al bosque?", "sage")

func _on_Bobs_House_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		_instantiate_confirmation_text_box("¿Ir a la casa de Bob?", "bob")

func _instantiate_confirmation_text_box(text_to_show, scene_to_change):
	var text_box = load("res://frontend/GUI/ConfirmationTextBox.tscn").instance()
	self.add_child(text_box)
	text_box.scene_to_change = scene_to_change
	text_box.text_to_show = text_to_show
	text_box.assign_text()
	text_box.set_position(Vector2(0.032, -0.592))
	text_box.visible = true

func _on_Jhons_House_mouse_entered():
	jhon_label.visible = true

func _on_Jhons_House_mouse_exited():
	jhon_label.visible = false

func _on_Factory_mouse_entered():
	factory_label.visible = true

func _on_Factory_mouse_exited():
	factory_label.visible = false

func _on_Sages_Woods_mouse_entered():
	sage_label.visible = true

func _on_Sages_Woods_mouse_exited():
	sage_label.visible = false

func _on_Bobs_House_mouse_entered():
	bob_label.visible = true

func _on_Bobs_House_mouse_exited():
	bob_label.visible = false
