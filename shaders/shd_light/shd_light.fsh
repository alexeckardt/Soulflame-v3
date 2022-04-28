varying vec2 pos; //current pixel position
varying vec4 col; //current pixel position
varying vec2 v_vTexcoord;


uniform vec2 u_pos; //light source positon
uniform float zz; //larger zz, larger light
uniform float u_str; //stronger intensity light
uniform float u_dir; //direction
uniform float u_fov; //fov

#define TAU 6.283184 //twice pi, speed up calcs

void main(){
	vec2 dis = pos - u_pos;
	float str = 1./(sqrt(dis.x*dis.x + dis.y*dis.y + zz*zz)-zz+1.-u_str); //strength of light is the inverse distance
	float dir = radians(u_dir);
	float hfov = radians(u_fov)*0.5;
	
	if (hfov < TAU*0.5){
		float rad = atan(-dis.y, dis.x);
		float adis = abs(mod(rad+TAU,TAU) - dir);
		adis = min(adis,TAU - adis);
		str *= clamp((1.-adis/hfov)*5., 0., 1.);
	}

	vec4 frag = texture2D( gm_BaseTexture, v_vTexcoord );
    gl_FragColor = col*vec4(vec3(str),1.)*frag;
}
