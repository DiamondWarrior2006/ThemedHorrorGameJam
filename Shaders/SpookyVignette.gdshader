shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, repeat_disable, filter_linear_mipmap;
uniform sampler2D noise_texture: repeat_enable;

uniform float blur_radius : hint_range(0, 1) = 0.2; // Radius of the blur effect
uniform float blur_amount : hint_range(0, 5) = 1.0; // Strength of the blur effect
uniform float blur_inner : hint_range(0, 1) = 0.6; // Inner edge of the blur effect
uniform float blur_outer : hint_range(0, 1) = 0.66; // Outer edge of the blur effect

uniform float scroll_speed=0.1;
uniform vec2 direction = vec2(1.0,0.0);

void fragment() {
    // Original color of the pixel from the screen
    vec4 pixelColor = texture(screen_texture, UV);
    
    // Color with blur effect from the screen
    vec4 blurColor = textureLod(screen_texture, SCREEN_UV, blur_amount);

    // Calculate distance from the center of the screen
    float distance = length(UV - vec2(0.5, 0.5));

    // Apply smoothstep function to control transition between areas
    float blur = smoothstep(blur_inner - blur_radius, blur_outer, distance);

    // Mix colors of the blur effect and the original color based on the smoothstep value
    pixelColor.rgb = mix(blurColor.rgb, COLOR.rgb, -blur);

    // Set the alpha component of the blur effect to the smoothstep value
    blurColor.a = blur;

    // Mix colors of the blur effect with white for an additional effect
    blurColor.rgb = mix(blurColor.rgb, vec3(0.0), 0.5) * texture(noise_texture,UV+ (direction * TIME * scroll_speed)).rgb;
	//vec4 finalTexture = texture(blurColor, UV + (direction * TIME * scroll_speed) );

    // Set the final color to the modified color of the blur effect
    COLOR = blurColor;
}