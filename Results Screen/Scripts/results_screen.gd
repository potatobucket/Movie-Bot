extends Node

@onready var discordButton := $DiscordButton
@onready var fade := $Fade
@onready var http := $HTTPRequest
@onready var marquees := $Marquees
@onready var marquee := preload("res://Results Screen/Scenes/marquee.tscn")
@onready var nameArray := StaticData.nameList
@onready var discordJSONPath := "res://Results Screen/Movie Bot embed.json"

func _ready():
	nameArray.shuffle()
	http.connect("requestDenied", _on_requestDenied)
	http.connect("requestAccepted", _on_requestAccepted)
	HelperFunctions.play_animation(fade, "fadeIn")
	for moniker in nameArray:
		create_marquee(moniker)

func create_marquee(marqueeName := "Test"):
	var newMarquee = marquee.instantiate()
	marquees.add_child(newMarquee)
	newMarquee.nameData = marqueeName
	newMarquee.connect("revealFinished", _on_revealFinished)

func check_if_all_finished():
	for child in marquees.get_children():
		if !child.revealed:
			return false
	return true

func load_discord_JSON(path := discordJSONPath):
	var loadedJSON = FileAccess.open(path, FileAccess.READ)
	var parsedDiscordJSON = JSON.parse_string(loadedJSON.get_as_text())
	return parsedDiscordJSON

func _on_revealFinished():
	if check_if_all_finished():
		await get_tree().create_timer(0.6).timeout
		discordButton.show()

func _on_requestDenied():
	discordButton.set_text("It didn't work!")
	discordButton.disabled = false

func _on_requestAccepted():
	discordButton.set_text("Sent to Discord!")
	discordButton.disabled = true

func _on_discord_button_pressed():
	var discordBody = load_discord_JSON()
	var date := Date.new()
	discordButton.disabled = true
	discordButton.set_text("Working on it...")
	discordBody["embeds"][0]["fields"][0]["value"] = "\n".join(StaticData.nameList)
	discordBody["embeds"][0]["fields"][1]["value"] = date.get_formatted_dates(StaticData.nameList)
	http.send_patch_request(discordBody)
