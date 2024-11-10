extends Node

func play_animation(animatedSprite: AnimatedSprite2D, animation := "default", backwards := false):
	match backwards:
		false:
			animatedSprite.play(animation)
		true:
			animatedSprite.play_backwards(animation)

func save(savePath := "user://names.moviebot"):
	var file = FileAccess.open(savePath, FileAccess.WRITE)
	file.store_var(StaticData.nameList)

func load_data(savePath := "user://names.moviebot"):
	if FileAccess.file_exists(savePath):
		var file = FileAccess.open(savePath, FileAccess.READ)
		StaticData.nameList = file.get_var()
	else:
		print("No data")
		StaticData.nameList = []

func load_alphabet_json(alphabetJSON := "res://Results Screen/alphabet.json"):
	var alphabetFile := FileAccess.open(alphabetJSON, FileAccess.READ)
	var parsedAlphabet = JSON.parse_string(alphabetFile.get_as_text())
	return parsedAlphabet
