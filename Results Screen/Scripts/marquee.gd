extends Control

signal revealFinished

#region Onready Variables
@onready var letterOne := $Control/Letter1
@onready var letterTwo := $Control/Letter2
@onready var letterThree := $Control/Letter3
@onready var letterFour := $Control/Letter4
@onready var letterFive := $Control/Letter5
@onready var letterSix := $Control/Letter6
@onready var letterSeven := $Control/Letter7
@onready var letterEight := $Control/Letter8
@onready var letterNine := $Control/Letter9
@onready var letterTen := $Control/Letter10
@onready var displays := [
	letterOne,
	letterTwo,
	letterThree,
	letterFour,
	letterFive,
	letterSix,
	letterSeven,
	letterEight,
	letterNine,
	letterTen
]

@onready var alphabet = HelperFunctions.load_alphabet_json()
@onready var revealButton := $RevealButton
@onready var revealSound := $RevealSound
@onready var revealTimer := $RevealTimer
@onready var ding := $Ding
#endregion

var nameData := "Test"
var scrapedLetters := []
var revealed := false

func scrape_letters(word := "Test"):
	for letter in word:
		scrapedLetters.append(letter)
	return scrapedLetters

func reveal():
	revealSound.play()
	for display in displays:
		await get_tree().create_timer(0.001).timeout
		display.set_frame(1)
	revealTimer.start()

func set_letter_frame(letters := []):
	for letter in range(letters.size()):
		displays[letter].set_frame(alphabet[letters[letter]])

func _on_reveal_button_pressed():
	reveal()
	revealed = true
	revealButton.disabled = true
	emit_signal("revealFinished")

func _on_reveal_timer_timeout():
	ding.play()
	set_letter_frame(scrape_letters(nameData))
