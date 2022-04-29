varying vec2 pos; //current pixel position
varying vec4 col;
varying vec2 v_vTexcoord;

uniform vec2 u_pos; //light souce position
uniform float u_zz; //light point size
uniform float u_dir; //light beam direction
uniform float u_fov; //light beam fov
uniform float u_falloff; //distance light travels basically
uniform float u_str;

//Define
#define PI 3.1415926538
#define spotlight_harshness 3.
#define scale 4.
#define cutoff 0.0005

void main() {
	
	vec2 dis = (pos - u_pos) / scale;
	
	//Determine Strength Of Light
	float str_base = 1.0 / (sqrt(dis.x*dis.x + dis.y*dis.y + u_zz*u_zz) - u_zz + 1. - u_str);
	
	//Cutoff Light if it's value is UNder the cutoff value
	float str = str_base * floor(min(str_base + 1. - cutoff, 1.));
	
	float dir = radians(u_dir);
	float hfov = radians(u_fov) * 0.5;
	
	//https://www.youtube.com/watch?v=RM31OgQ6NeQ&list=PLYVea5brHS8YHECGPoEp4_gWU-k6nWzUy&index=4
	if (hfov < PI) {
		float rad = atan(-dis.y, dis.x);
		float adis = abs(mod(rad+2.*PI, 2.*PI) - dir);
		
		//Get The Smaller Angle
		adis = min(adis, 2.*PI - adis);
		
		//Strength 0 if angle not within range; Fade
		str *= clamp(1. - (adis / hfov) * spotlight_harshness, 0., 1.);	
	}
	
	vec4 frag = texture2D( gm_BaseTexture, v_vTexcoord );
    gl_FragColor = col * vec4(vec3(pow(str,u_falloff)), 1.) * frag;
}
