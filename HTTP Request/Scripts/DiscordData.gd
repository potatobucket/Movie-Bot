extends Node

#NOTE: webhookURL should be replaced with your actual webhook URL. This is a placeholder.
var webhookURL := "https://discord.com/api/webhooks/<server id>/<channel id>"

#NOTE: this section is largely a placeholder and will be replaced in code later
var discordBody := {
  "content": "",
  "tts": false,
  "embeds": [
	{
	  "id": 159357456,
	  "title": "This is where the title of your Discord embed goes.",
	  "description": "This is where the description of your Discord embed goes.",
	  "url": "You can put a URL here.",
	  "color": 1193046,
	  "author": {
		"name": "The name of your bot.",
		"url": "A URL for your bot (optional?)",
		"icon_url": "The URL pointing to an image for your bot's icon."
	  },
	  "fields": []
	}
  ],
  "components": [],
  "actions": {}
}
