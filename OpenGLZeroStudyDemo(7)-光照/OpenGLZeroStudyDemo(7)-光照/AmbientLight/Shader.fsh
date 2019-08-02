precision lowp float;
uniform sampler2D       u_samplers2D[1];
varying  vec2      vary_texture;
uniform vec4   ambientLight; ///环境光

void main()
{
    ///环境光的使用
     vec4 textureColor = texture2D(u_samplers2D[0],vary_texture);
    float  ambientStrength = 0.5;
    vec4 ambient = ambientStrength * ambientLight;
    gl_FragColor = ambient * textureColor;
}
