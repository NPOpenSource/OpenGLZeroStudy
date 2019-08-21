precision mediump float;
varying vec2 vTexCoords;
uniform sampler2D uTexture;

void main()
{
    vec4 textureColor = texture2D(uTexture, vTexCoords);
    gl_FragColor = vec4(vec3(gl_FragCoord.z), 1.0);;
}
