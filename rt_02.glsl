/*
	draw a simple rect
*/
#define PI_TWO			1.570796326794897
#define PI					3.141592653589793
#define TWO_PI			6.283185307179586

#define SCREEN_WIDTH iResolution.x
#define SCREEN_HEIGHT iResolution.y

// operate in normalized device coordinates
vec4 mainImage(in vec2 fragCoord) {
	vec4 fragColor = vec4(0., 0., 0., 1.);

	//let's assume a rect between 0.25 - 0.5 x and y
	float w = 1.;
	float h = 1.; 
	float x = -.5;
	float y = -.5;
	if (fragCoord.x >= x && fragCoord.x <= x + w && 
		  fragCoord.y >= y && fragCoord.y <= y + h) {
			fragColor.rgb = vec3(fragCoord.x, fragCoord.y, fragCoord.x*fragCoord.y);
	} 

	return fragColor;
}

void main() {

	mat4 ndc = mat4(
		2./ SCREEN_WIDTH, 0., 0., 1.,
		0., 2./ SCREEN_HEIGHT, 0., 1.,
		0., 0., 1., 1.,
		-1., -1., 0., 1.
	);

	vec4 v_ndc = ndc * gl_FragCoord;

	gl_FragColor = mainImage(v_ndc.xy);
}