shader_type canvas_item;

uniform sampler2D noise;
uniform float intensity = 1.15;
uniform float timeMultiplier: hint_range(1.5, 50.0) = 2.0;

void fragment() {
	vec3 spriteColor = COLOR.rgb;
	vec4 noiseVec4 = texture(noise, UV);
	float timeValue = cos(TIME * timeMultiplier);
	
	COLOR.rgb = mix(spriteColor, noiseVec4.rgb, intensity * timeValue);
}
