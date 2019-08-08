precision mediump float;

uniform vec3 viewPos;

varying lowp vec3 normal;
varying lowp vec3 FragPos;

varying lowp vec2 v_texture;

struct Light{
    vec3 position;
    
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
    
    float constant;
    float linear;
    float quadratic;
};
uniform Light light;

struct Material{
    sampler2D diffuse;
    sampler2D specular;
    float shininess;
};
uniform Material material;

void main(){
   
    
    // 环境光
    vec3 diffuseT =vec3(texture2D(material.diffuse,v_texture));
    vec3 specularT =vec3(texture2D(material.specular,v_texture));

    vec3 ambient = light.ambient * diffuseT;

    // 漫反射
    vec3 norm = normalize(normal);
    vec3 lightDir = normalize(light.position - FragPos);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = light.diffuse * (diff * diffuseT);

  // 镜面光
    vec3 viewDir = normalize(viewPos - FragPos);
    vec3 reflectDir = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess*128.0);
    vec3 specular = light.specular * (spec * specularT);

    
    float distance    = length(light.position - FragPos);
    float attenuation = 1.0 / (light.constant + light.linear * distance +
                               light.quadratic * (distance * distance));
    
    ambient  *= attenuation;
    diffuse   *= attenuation;
    specular *= attenuation;   
    vec3 result = ambient + diffuse + specular;

    gl_FragColor =vec4(result, 1.0);;

}


