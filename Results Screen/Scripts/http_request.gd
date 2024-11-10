extends HTTPRequest

signal requestAccepted
signal requestDenied

func _on_request_completed(_result, response_code, _headers, _body):
	if response_code != 200:
		emit_signal("requestDenied")
		print(response_code)
	else:
		emit_signal("requestAccepted")

func send_patch_request(JSONData := {}):
	var headers := ["Content-Type: application/json"]
	var url := DiscordData.webhookURL
	self.request(url, headers, HTTPClient.METHOD_PATCH, JSON.stringify(JSONData))
