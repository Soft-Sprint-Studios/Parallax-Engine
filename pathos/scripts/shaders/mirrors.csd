CSD1   766a7f44d43431249e79658dd589c255    �	     @      
  `   �  �  �  �  �  0  �  #version 460

uniform mat4 projection;
uniform mat4 modelview;

uniform mat4 mirror_matrix;

in vec4 in_position;

out vec4 ps_texcoord;
out vec3 ps_vertexpos;

void main()
{
	vec4 texcoord = in_position*mirror_matrix;
	ps_texcoord = texcoord*projection;

	vec4 position = in_position*modelview;
	ps_vertexpos = position.xyz;
	gl_Position = position*projection;
	
}
#version 460

uniform sampler2D texture0;

uniform float dt_x;
uniform float dt_y;

uniform vec3 fogcolor;
uniform vec2 fogparams;

in vec4 ps_texcoord;
in vec3 ps_vertexpos;

out vec4 oColor;

float SplineFraction( float value, float scale )
{
	float valueSquared;

	value = scale * value;
	valueSquared = value * value;

	// Nice little ease-in, ease-out spline-like curve
	return 3 * valueSquared - 2 * valueSquared * value;
}

void main()
{
	vec2 mirror_tc = ps_texcoord.xy;
	mirror_tc.x *= dt_x;
	mirror_tc.y *= dt_y;

	mirror_tc = mirror_tc/(ps_texcoord.w*2);
	mirror_tc = mirror_tc + 0.5;

	vec4 finalColor = texture2D(texture0, mirror_tc);

	oColor = finalColor;
}
#version 460

uniform mat4 projection;
uniform mat4 modelview;

uniform mat4 mirror_matrix;

in vec4 in_position;

out vec4 ps_texcoord;
out vec3 ps_vertexpos;

void main()
{
	vec4 texcoord = in_position*mirror_matrix;
	ps_texcoord = texcoord*projection;

	vec4 position = in_position*modelview;
	ps_vertexpos = position.xyz;
	gl_Position = position*projection;
	
}
#version 460

uniform sampler2D texture0;

uniform float dt_x;
uniform float dt_y;

uniform vec3 fogcolor;
uniform vec2 fogparams;

in vec4 ps_texcoord;
in vec3 ps_vertexpos;

out vec4 oColor;

float SplineFraction( float value, float scale )
{
	float valueSquared;

	value = scale * value;
	valueSquared = value * value;

	// Nice little ease-in, ease-out spline-like curve
	return 3 * valueSquared - 2 * valueSquared * value;
}

void main()
{
	vec2 mirror_tc = ps_texcoord.xy;
	mirror_tc.x *= dt_x;
	mirror_tc.y *= dt_y;

	mirror_tc = mirror_tc/(ps_texcoord.w*2);
	mirror_tc = mirror_tc + 0.5;

	vec4 finalColor = texture2D(texture0, mirror_tc);

	float fogcoord = length(ps_vertexpos);
		
		float fogfactor = (fogparams.x - fogcoord)*fogparams.y;
		fogfactor = 1.0-SplineFraction(clamp(fogfactor, 0.0, 1.0), 1.0);
		
		finalColor.xyz = mix(finalColor.xyz, fogcolor, fogfactor);
	oColor = finalColor;
}
fog                                
            