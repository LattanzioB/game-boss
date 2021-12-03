extends Node

func _ready():
	pass

func _on_Jhons_House_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		_instantiate_confirmation_text_box("¿Ir a la casa de Juan?", "jhon")

func _on_Factory_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		_instantiate_confirmation_text_box("¿Ir a la fábrica?", "factory")

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
