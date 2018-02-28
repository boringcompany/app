void main() {
    // Find the distance to the closest border
    vec2 uv = v_tex_coord;
    float minX = min(v_tex_coord.x, 1. - v_tex_coord.x);
    float minY = min(v_tex_coord.y, 1. - v_tex_coord.y);
    float dist = max(.25 - min(minX, minY), 0.) * 4.;
    // Find the pixel at the coordinate of the actual texture
    vec4 textureColor = texture2D(u_texture, v_tex_coord);
    // Base overlay color #2a94c1
    vec4 overlayColor = vec4(.1647, .5804, .7569, 1.);
    // Calculate the final color
    gl_FragColor = mix(textureColor, overlayColor, dist);
}
