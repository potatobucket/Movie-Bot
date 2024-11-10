shader_type canvas_item;

uniform float intensity : hint_range(0.0, 50.0) = 3.0;

void vertex() {
	VERTEX += sin(TIME) * intensity;
}
