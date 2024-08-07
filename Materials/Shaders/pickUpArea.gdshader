shader_type spatial;
render_mode cull_disabled;

uniform float cylinder_h = 2.0;
uniform float bottom_alpha = 0.2;
uniform vec4 glow_color : source_color = vec4(0.0, 1.0, 0.0, 1.0);
uniform float glow_strength : hint_range(0, 10) = 3.0;
uniform float pulse_speed : hint_range(0, 10) = 2.0;

varying float height;

// Called for every vertex the material is visible on.
void vertex() {
    height = VERTEX.y;
}

// Called for every pixel the material is visible on.
void fragment() {
    // Use height for vertical glow effect
    float glow_gradient = -height / cylinder_h;
    // Pulsating effect
    float pulse = (sin(TIME * pulse_speed) + 1.0) * 0.5;
    
	ALBEDO = glow_color.rgb;
    //EMISSION = glow_color.rgb * glow_strength * glow_gradient * pulse;
	if(height == -cylinder_h/2.0) { // bottom cap stays the same
		ALPHA = bottom_alpha;
	} else {
		ALPHA = glow_gradient * pulse;
	}
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
