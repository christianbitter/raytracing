/*
	draw a simple circle
*/
#define PI_TWO			1.570796326794897
#define PI					3.141592653589793
#define TWO_PI			6.283185307179586


#define ALIASING_SAMPLES 1

#define SCREEN_WIDTH iResolution.x
#define SCREEN_HEIGHT iResolution.y
#define Z_NEAR -1.
#define Z_FAR   1.


#define CIRCLE_X 0.25
#define CIRCLE_Y 0.25
#define CIRCLE_Z 0.
#define CIRCLE_R 0.25
#define MAX_SPHERES 4

struct Circle {
	vec3 c;
	float r;
	vec3 color;
};

struct Sphere {
	vec3 c;
	float r;
	vec3 color;
};

struct Scene {
	Sphere[MAX_SPHERES] spheres;
};

bool makeScene(out Scene the_scene) {	
	return(false);
}

float seed = 0.0;

vec3 bgColor = vec3(1., 1., 1);

// random number between 0 and 1
float random() {
    return fract(sin(seed++)*43758.5453123);
}


// operate in normalized device coordinates
vec4 mainImage(in vec2 fragCoord) {
	vec4 fragColor = vec4(bgColor, 1.);

	Circle c = Circle(
		vec3(CIRCLE_X, CIRCLE_Y, CIRCLE_Z),
		CIRCLE_R, 
	vec3(.5, 0., .5)
	);

	//let's draw a circle of radius r, centered at x = 0, y = 0
	//r^2 = x^2 + y^2
	//points in the circle need to have r^2 <= x_i^2 + y_i^2
	// r <= sqrt((x-x_i)^2 + (y-y_i)^2)
	vec3 ctr = vec3(CIRCLE_X, CIRCLE_Y, 0.);
	vec3 d = c.c - vec3(fragCoord, 0.);
	float ri = sqrt(d.x*d.x + d.y*d.y);

	if (ri <= sqrt(c.r)) {
		fragColor = vec4(c.color, 1.);
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

	//oversample and get the contribution
	vec4 fragColor = vec4(0., 0., 0., 0.);
	float frac_alias = 1. / float(ALIASING_SAMPLES);

	for (int i = 0; i < ALIASING_SAMPLES; i++) {
		//introduce oversampling
		vec4 jitter = vec4(random() - 0.5, random() - 0.5, 0., 0.0);
		vec4 pxy = gl_FragCoord + jitter;

		vec4 v_ndc = ndc * pxy;
		vec4 t_fragColor = mainImage(v_ndc.xy);	
		fragColor = fragColor + t_fragColor;
	}

	fragColor = frac_alias * fragColor;

	gl_FragColor = fragColor;
}