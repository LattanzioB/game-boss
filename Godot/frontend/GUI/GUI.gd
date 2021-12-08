extends Control

signal change_scene
signal music_loop

onready var chatbox = $Chatbox
onready var sound_control = $SoundControl
onready var journal = $Journal
onready var rec = $Rec
onready var sfx = $SFx
onready var map = $Map
onready var journal_button = $Journal_on_button
onready var map_button = $Map_on_button
onready var thinking_bubble = $Thinking_bubble

# Called when the node enters the scene tree for the first time.
func _ready():
	sfx.stream = load("res://assets/sfx/correct.mp3")
	sfx.stream.set_loop(false)


func _process(delta):
	if Input.is_action_just_released("talk") && (!rec.visible):
		rec.visible = true
	elif Input.is_action_just_released("talk") && (rec.visible):
		rec.visible = false


func reset():
	chatbox.clear()
	sound_control.visible = false
	journal.visible = false
	sfx.stop()
	map.visible = false 

func chatbox_spawn_npc_tile(text):
	chatbox.spawn_npc_tile(text)



func _on_ConfigurationGear_pressed():
	sound_control.visible = !sound_control.visible



func _on_FireFx_volume_control_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BackgroundFx"), value)


func _on_NPC_voice_volume_control_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Voices"), value)

func _on_Music_volume_control_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BaseMelody"), value)


func _on_Journal_on_button_pressed():
	journal.visible = !journal.visible


func _on_Journal_journal_complete(npc_name):\
	if (npc_name == 'juan'):
		get_parent().start_scene_changer_timer()


func _on_Journal_new_trigger_found(trigger):
	sfx.play()



func _on_Journal_on_button_mouse_entered():
	$JournalTooltip.visible = true


func _on_Journal_on_button_mouse_exited():
	$JournalTooltip.visible = false


func _on_ConfigurationGear_mouse_entered():
	$SettingsTooltip.visible = true


func _on_ConfigurationGear_mouse_exited():
	$SettingsTooltip.visible = false



func _on_Map_on_button_pressed():
	map.visible = !map.visible


func _on_Map_on_button_mouse_entered():
	$MapTooltip.visible = true


func _on_Map_on_button_mouse_exited():
	$MapTooltip.visible = false


func _on_Map_change_scene(scene):
	emit_signal("change_scene", scene)


func _on_Journal_first_trigger():
	journal.visible = true


func _on_CheckBox_pressed():
	emit_signal("music_loop")
