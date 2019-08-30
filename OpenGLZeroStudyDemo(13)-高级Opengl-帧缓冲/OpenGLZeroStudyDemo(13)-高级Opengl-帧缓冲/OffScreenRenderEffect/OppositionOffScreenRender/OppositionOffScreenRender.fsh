precision mediump float;
varying vec2 vTexCoords;
uniform sampler2D uTexture;

const float offset = 1.0 / 300.0;

void main()
{
    vec3  textureColor = texture2D(uTexture, vTexCoords).rgb;
    gl_FragColor = vec4(vec3(1.0)-textureColor,1.0);
}

