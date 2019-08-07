precision mediump float;

uniform vec3 viewPos;

varying lowp vec3 normal;
varying lowp vec3 FragPos;

varying lowp vec2 v_texture;

struct Light{
    vec3 lightPos;
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};
uniform Light light;

struct Material{
    sampler2D diffuse;
    vec3 specular;
    float shininess;
};
uniform Material material;

void main(){
    // 环境光
    vec3 diffuseT =vec3(texture2D(material.diffuse,v_texture));

    vec3 ambient = light.ambient * diffuseT;

    // 漫反射
    vec3 norm = normalize(normal);
    vec3 lightDir = normalize(light.lightPos - FragPos);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = light.diffuse * (diff * diffuseT);

  // 镜面光
    vec3 viewDir = normalize(viewPos - FragPos);
    vec3 reflectDir = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess*128.0);
    vec3 specular = light.specular * (spec * material.specular);

    vec3 result = ambient + diffuse + specular;
    gl_FragColor =vec4(result, 1.0);;

}


