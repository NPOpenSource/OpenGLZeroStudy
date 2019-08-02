precision lowp float;
uniform vec3 lightPos; ///光源位置
uniform vec3 lightColor; ///光源位置

varying lowp vec3 normal;
varying lowp vec3 FragPos;
varying lowp vec3 vary_vertexColor;

void main()
{
    vec3 norm = normalize(normal);
    vec3 lightDir = normalize(lightPos - FragPos);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = diff * lightColor;
    ///环境光的使用
    gl_FragColor =vec4(diffuse,1.0) * vec4( vary_vertexColor,1.0);;
}
