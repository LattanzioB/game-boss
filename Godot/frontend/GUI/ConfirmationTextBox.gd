extends Node2D

var text_label
var text_to_show
var scene_to_change

signal change_scene

func _ready():
	self.visible = false
	text_label = $TextLabel

func _on_ConfirmationButton_pressed():
	emit_signal("change_scene", scene_to_change)

func assign_text():
	text_label.set_text(text_to_show)

func _on_CancelButton_pressed():
	get_parent().remove_child(self)
