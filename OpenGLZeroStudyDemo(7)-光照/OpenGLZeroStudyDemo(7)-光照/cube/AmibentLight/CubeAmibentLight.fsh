precision lowp float;

varying lowp vec3 vary_vertexColor;
uniform vec4   ambientLight; ///环境光

void main()
{
    float  ambientStrength = 0.2;
    vec4 ambient = ambientStrength * ambientLight;
    gl_FragColor = ambient * vec4( vary_vertexColor,1.0);;
}
