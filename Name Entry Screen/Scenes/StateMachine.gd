extends Node

signal change_states

enum {
	INITIAL,
	CHECK_FOR_FILE,
	NAME_ENTRY,
	FINISHED
}
