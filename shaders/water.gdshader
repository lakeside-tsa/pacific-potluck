// https://www.youtube.com/watch?v=uYGjFo5rqnw

shader_type canvas_item;
uniform vec4 color : source_color;
uniform sampler2D fast_noise: repeat_enable;
uniform sampler2D screen_content: hint_screen_texture;
uniform vec2 speed = vec2(0.02, 0.08);
uniform float wave_strength = 2.0;
uniform float fade_start = 0.2;
uniform float fade_end = 0.8;

void fragment() {
    vec2 uv = UV + speed * TIME;
    vec2 noise = texture(fast_noise, uv).rg;

    float fade_factor = smoothstep(fade_start, fade_end, UV.y);

    vec4 base_color = vec4(color.rgb, 1.0);
    vec4 noise_color = vec4(noise.x, noise.y, 0.0, 0.0) * fade_factor;
    vec4 final_color = base_color + noise_color;

    COLOR = final_color * texture(screen_content, SCREEN_UV + noise * (wave_strength / 100.0) * fade_factor);
}