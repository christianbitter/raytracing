/*
	draw a simple rect
*/
#define PI_TWO			1.570796326794897
#define PI					3.141592653589793
#define TWO_PI			6.283185307179586

#define SCREEN_WIDTH iResolution.x
#define SCREEN_HEIGHT iResolution.y

// fragCoord is in screen coordinates / resolution i.e. 0,0 to 640,480
vec4 mainImage(in vec2 fragCoord) {
	vec4 fragColor = vec4(0., 0., 0., 1.);

	//let's assume a rect between 0.25 - 0.5 x and y
	float w = 50.;
	float h = 50.; 
	float x = (SCREEN_WIDTH / 2.) - (w / 2.);
	float y = (SCREEN_HEIGHT/ 2.) - (h / 2.);
	if (fragCoord.x >= x && fragCoord.x <= x + w && 
		  fragCoord.y >= y && fragCoord.y <= y + h) {
			fragColor.rgb = vec3(1., 1., 1.);
	} 

	return fragColor;
}

void main() {
	gl_FragColor = mainImage(gl_FragCoord.xy);
}