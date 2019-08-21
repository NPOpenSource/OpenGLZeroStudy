precision mediump float;
varying vec2 TexCoords;
uniform sampler2D texture_diffuse;
uniform sampler2D texture_specular;
uniform sampler2D texture_height;

void main()
{
    vec4 diffuse = texture2D(texture_diffuse, TexCoords);
    vec4 specular = texture2D(texture_specular, TexCoords);
    vec4 height = texture2D(texture_height, TexCoords);
    gl_FragColor = diffuse+specular+height;
}
