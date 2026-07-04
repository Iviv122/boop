shader_type canvas_item;

const float width = 0.1;

void fragment() {
	float dist = fract(TIME)*0.4;
	
	float val  = step(dist,UV.x)-step(1.-dist,UV.x);
	float val1 = step(dist,UV.y)-step(1.-dist,UV.y);
	float a = val*val1;
	
	val  = step(dist+width,UV.x)-step(1.-dist-width,UV.x);
	val1 = step(dist+width,UV.y)-step(1.-dist-width,UV.y);
	a -= val*val1;
	
	a = 1.-a*0.8;
	
	COLOR = vec4(COLOR.rgb*a,1.); 
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
