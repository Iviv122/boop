shader_type canvas_item;

const float off = .01;
const float speed = 5.;
uniform vec4 color;

void fragment() {
	
    float y = UV.y - 0.5;
    float x = UV.x - 0.5;
	float dist = 1.-sqrt(y*y+x*x)*2.;
    
	float diff = off*sin(TIME*speed);
	float a = step(0.4+diff,dist/2.);

    COLOR = vec4(color.rgb,a*color.a);
}