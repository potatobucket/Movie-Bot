extends HTTPRequest

@onready var passFail := $Pass_Fail

func _ready():
	passFail.hide()

func pass_fail_set_text(text := ""):
	passFail.set_text(text)
	passFail.show()

func _on_request_completed(_result, response_code, _headers, _body):
	if response_code != 200:
		pass_fail_set_text("Something went wrong!")
	else:
		pass_fail_set_text("Success!")

func _on_push_to_discord_pressed():
	var headers := ["Content-Type: application/json"]
	var url := DiscordData.webhookURL
	self.request(url, headers, HTTPClient.METHOD_PATCH, JSON.stringify(DiscordData.discordBody))
	pass_fail_set_text("Working...")
