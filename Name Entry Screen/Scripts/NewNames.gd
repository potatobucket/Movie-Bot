extends Control

signal name_entry_finished

@onready var goButton := $VBoxContainer/GoButton
@onready var namesList := $VBoxContainer/NamesList
@onready var nameEntry := $VBoxContainer/NameEntry
@onready var submitButton := $VBoxContainer/SubmitButton

func _ready():
	nameEntry.grab_focus()
	goButton.hide()

func check_length_of_name_array(nameArray := StaticData.nameList):
	if nameArray.size() >= 2:
		goButton.show()
	elif nameArray.size() < 2:
		goButton.hide()

func _on_submit_button_pressed():
	if !namesList.visible:
		namesList.show()
	if nameEntry.text != nameEntry.placeholder_text && nameEntry.text != "":
		StaticData.nameList.append(nameEntry.text)
		nameEntry.clear()
		namesList.set_text(",\n".join(StaticData.nameList))
	check_length_of_name_array(StaticData.nameList)

func _on_delete_last_button_pressed():
	if !StaticData.nameList.is_empty():
		StaticData.nameList.pop_back()
		namesList.set_text(",\n".join(StaticData.nameList))
	check_length_of_name_array(StaticData.nameList)

func _on_name_entry_text_submitted(_new_text):
	_on_submit_button_pressed()

func _on_go_button_pressed():
	emit_signal("name_entry_finished")
