precision lowp float;
uniform vec3 lightPos; ///光源位置
uniform vec3 lightColor; ///光源位置

uniform vec3 viewPos;

uniform vec3  ambientLight; ///环境光

varying lowp vec3 normal;
varying lowp vec3 FragPos;
varying lowp vec3 vary_vertexColor;

void main()
{
    float  ambientStrength = 0.2;
    vec3 ambient = ambientStrength * ambientLight;
    
    float specularStrength = 0.5;
    vec3 norm = normalize(normal);
    vec3 lightDir = normalize(lightPos - FragPos);
    vec3 viewDir = normalize(viewPos - FragPos);
    vec3 reflectDir = reflect(-lightDir, norm);
    lowp float spec = pow(max(dot(viewDir, reflectDir), 0.0), 0.5);
    vec3 specular = specularStrength * spec * lightColor;
 
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = diff * lightColor;
    
    gl_FragColor =vec4(ambient+specular+diffuse,1.0) * vec4( vary_vertexColor,1.0);
}
