extends Control

signal finished
signal newNames

@onready var loadButton := $VBoxContainer/LoadButton
@onready var newNamesButton := $VBoxContainer/NewNamesButton

func _on_load_button_pressed():
	HelperFunctions.load_data()
	emit_signal("finished")

func _on_new_names_button_pressed():
	emit_signal("newNames")
