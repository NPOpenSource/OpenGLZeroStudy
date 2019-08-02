precision lowp float;
uniform sampler2D       u_samplers2D[1];
varying  vec2      vary_texture;

uniform vec4   ambientLight; ///环境光
uniform vec3 lightPos; ///光源位置
uniform vec3 lightColor; ///光源位置

varying lowp vec3 normal;
varying lowp vec3 FragPos;
void main()
{
    vec3 norm = normalize(normal);
    vec3 lightDir = normalize(lightPos - FragPos);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = diff * lightColor;
    ///环境光的使用
     vec4 textureColor = texture2D(u_samplers2D[0],vary_texture);
    float  ambientStrength = 0.1;
    vec4 ambient = ambientStrength * ambientLight;
    gl_FragColor =(ambient +vec4(diffuse,1.0)) * textureColor;
}
