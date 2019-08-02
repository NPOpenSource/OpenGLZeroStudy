precision lowp float;
uniform vec3 lightPos; ///光源位置
uniform vec3 lightColor; ///光源位置

uniform vec3 viewPos;

varying lowp vec3 normal;
varying lowp vec3 FragPos;
varying lowp vec3 vary_vertexColor;

void main()
{
    float specularStrength = 0.5;
    vec3 norm = normalize(normal);
    vec3 lightDir = normalize(lightPos - FragPos);
    vec3 viewDir = normalize(viewPos - FragPos);
    vec3 reflectDir = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), 256.0);
    vec3 specular = specularStrength * spec * lightColor;
    ///环境光的使用

    gl_FragColor =vec4(specular,1.0) * vec4( vary_vertexColor,1.0);;
}
