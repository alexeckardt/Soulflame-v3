varying vec2 pos; //current pixel position
varying vec2 v_vTexcoord;
varying vec4 col;

uniform vec2 u_pos; //light souce position
uniform float u_zz; //light point size
uniform float u_dir; //light beam direction
uniform float u_fov; //light beam fov
uniform float u_str;
uniform float u_range; //distance multiplier
uniform float u_falloff;


#define PI 3.1415926538
const float spotlight_harshness = 5.;

void main() {
	
	vec2 dis = pos - u_pos;
	float str = u_range / (sqrt(dis.x*dis.x + dis.y*dis.y + u_zz*u_zz) - u_zz + 1. - u_str);
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
	
	//Get Exisitng Pixel
	vec4 frag = texture2D( gm_BaseTexture, v_vTexcoord );
	
	//Set New Pixel
    gl_FragColor = col * vec4(vec3(str), 1.) * frag;
}
