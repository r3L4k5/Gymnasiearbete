shader_type canvas_item;

uniform vec3 smoke_color: source_color; //vec3(0.397, 0.416, 0.429);

void fragment() {
	COLOR.rgb = smoke_color;
}


