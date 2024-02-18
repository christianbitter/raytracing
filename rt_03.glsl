/*
	draw a simple rect
*/
#define PI_TWO			1.570796326794897
#define PI					3.141592653589793
#define TWO_PI			6.283185307179586

#define SCREEN_WIDTH iResolution.x
#define SCREEN_HEIGHT iResolution.y

#define CIRCLE_X 0.25
#define CIRCLE_Y 0.25
#define CIRCLE_R 0.25

// operate in normalized device coordinates
vec4 mainImage(in vec2 fragCoord) {
	vec4 fragColor = vec4(0., 0., 0., 1.);

	//let's draw a circle of radius r, centered at x = 0, y = 0
	//r^2 = x^2 + y^2
	//points in the circle need to have r^2 <= x_i^2 + y_i^2
	// r <= sqrt((x-x_i)^2 + (y-y_i)^2)
	vec3 ctr = vec3(CIRCLE_X, CIRCLE_Y, 0.);
	vec3 d = ctr - vec3(fragCoord, 0.);
	float ri = sqrt(d.x*d.x + d.y*d.y);

	if (ri <= sqrt(CIRCLE_R)) {
		fragColor = vec4(fragCoord.x, fragCoord.y, fragCoord.x * fragCoord.y, 1.);
	}

	return fragColor;
}

void main() {

	mat4 ndc = mat4(
		2./ iResolution.x, 0., 0., 1.,
		0., 2./ iResolution.y, 0., 1.,
		0., 0., 2./ iResolution.z, 1.,
		-1., -1., -1., 1.
	);

	vec4 v_ndc = ndc * gl_FragCoord;

	gl_FragColor = mainImage(v_ndc.xy);
}