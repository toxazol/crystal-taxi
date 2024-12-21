shader_type canvas_item;

void fragment() {
    vec2 center = vec2(0.5, 0.5);
    float radius = 0.45;
    float dist = distance(UV, center);
    
    vec4 color = texture(TEXTURE, UV);
    color.a *= step(dist, radius);
    
    COLOR = color;
}