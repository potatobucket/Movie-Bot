extends Node2D

@onready var fadeOut := $FadeOut
@onready var mark := $TitleMark
@onready var pressStart := $PressStart
@onready var timer := $Timer
@onready var title := $Title
@onready var movieFace := $MovieFace

func _ready():
	title.finished.connect(_on_title_finished)
	pressStart.hide()
	movieFace.hide()
	movieFace.set_frame(0)

func _process(_delta):
	title_drop()

func _unhandled_input(event):
	if event is InputEventKey and event.is_pressed() and !fadeOut.is_playing():
		change_scenes()

func change_scenes():
	HelperFunctions.play_animation(fadeOut, "fadeOut")

func title_drop():
	if title.position.y != mark.position.y:
		title.position.y += 1.0

func blink_press_start_label(timerDelay := 1.0):
	while pressStart.visible == true:
		await get_tree().create_timer(timerDelay).timeout
		if pressStart.visible == true:
			pressStart.visible = false
		else:
			pressStart.visible = true

func _on_title_finished():
	movieFace.show()
	HelperFunctions.play_animation(movieFace, "appear")

func _on_timer_timeout():
	if title.position.y == mark.position.y:
		title.emit_signal("finished")
		timer.stop()

func _on_movie_face_animation_finished():
	pressStart.show()

func _on_fade_out_animation_finished():
	get_tree().change_scene_to_file("res://Name Entry Screen/Scenes/name_entry_screen.tscn")
