extends Node2D

@onready var stateMachine := $StateMachine
@onready var currentState = stateMachine.INITIAL
@onready var fade := $Fade
@onready var loadScreen := $LoadScreen
@onready var newNames := $NewNames
@onready var holoEmitter := $HologramEmitter
@onready var movieFace := $MovieFace
@onready var shaderTimer := $MovieFace/ShaderTimer
@onready var scanlines := $Scanlines
@onready var noiseTexture = movieFace.material.get_shader_parameter("noise")

var cycles := randi() % 14

func _ready():
	randomize()
	match_case()
	loadScreen.connect("finished", _on_load_finished)
	loadScreen.connect("newNames", _on_newNames)
	newNames.connect("name_entry_finished", _on_name_entry_finished)

func match_case():
	match currentState:
		stateMachine.INITIAL:
			initial_animation()
		stateMachine.CHECK_FOR_FILE:
			check_for_save_file()
		stateMachine.NAME_ENTRY:
			loadScreen.hide()
			newNames.show()
		stateMachine.FINISHED:
			HelperFunctions.save()
			HelperFunctions.play_animation(fade, "fadeOut")

func check_for_save_file():
	if !FileAccess.file_exists("user://names.moviebot"):
		currentState = stateMachine.NAME_ENTRY
		match_case()
	else:
		newNames.hide()
		loadScreen.show()

func initial_animation():
	fade.set_frame(0)
	HelperFunctions.play_animation(fade, "fadeIn")

func reaveal_movie_face():
	movieFace.show()
	HelperFunctions.play_animation(movieFace, "fadeIn")

func _on_fade_animation_finished():
	if fade.get_animation() == "fadeIn":
		holoEmitter.show()
		HelperFunctions.play_animation(holoEmitter, "open")
	if fade.get_animation() == "fadeOut":
		get_tree().change_scene_to_file("res://Results Screen/Scenes/ResultsScreen.tscn")

func _on_movie_emitter_animation_finished():
	if holoEmitter.get_animation() == "open":
		HelperFunctions.play_animation(holoEmitter, "running")
		reaveal_movie_face()

func _on_movie_face_animation_finished():
	movieFace.set_animation("glitch")
	movieFace.set_frame(0)
	movieFace.material.set_shader_parameter("intensity", 0.0)
	shaderTimer.stop()
	scanlines.show()
	currentState = stateMachine.CHECK_FOR_FILE
	match_case()

func _on_load_finished():
	currentState = stateMachine.FINISHED
	match_case()

func _on_newNames():
	currentState = stateMachine.NAME_ENTRY
	match_case()

func _on_name_entry_finished():
	currentState = stateMachine.FINISHED
	match_case()

func _on_shader_timer_timeout():
	noiseTexture.noise.seed += cycles
	movieFace.material.set_shader_parameter("noise", noiseTexture)
	movieFace.material.set_shader_parameter("timeMultiplier", randf_range(1.5, 50.0))
	cycles += 1
