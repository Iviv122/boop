shader_type canvas_item;

uniform vec4 color;
const float OFF=.01,SPEED=5.;

void fragment(){
	vec2 p=UV-.5;
	float d=1.-length(p)*2.;
	float a=step(.4+OFF*sin(TIME*SPEED),d*.5);
	COLOR=vec4(color.rgb,a*color.a);
}