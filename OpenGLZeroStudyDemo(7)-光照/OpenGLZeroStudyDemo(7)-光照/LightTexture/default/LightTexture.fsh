precision mediump float;
uniform vec3 lightPos; ///光源位置
uniform vec3 lightColor; ///光源颜色

uniform vec3 viewPos;

varying lowp vec3 normal;
varying lowp vec3 FragPos;
//varying lowp vec3 vary_vertexColor;
varying lowp vec3 v_texture;

struct Material{
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
    float shininess;
};
uniform Material material;

struct Light{
    vec3 lightPos;
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};
uniform Light light;



void main(){
    // 环境光
    
    vec3 ambient = light.ambient * material.ambient;
    
    // 漫反射
    vec3 norm = normalize(normal);
    vec3 lightDir = normalize(light.lightPos - FragPos);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = light.diffuse * (diff * material.diffuse);
    
    // 镜面光
    vec3 viewDir = normalize(viewPos - FragPos);
    vec3 reflectDir = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess*128.0);
    vec3 specular = light.specular * (spec * material.specular);
    
    vec3 result = ambient + diffuse + specular;
    gl_FragColor =vec4(result, 1.0);;
}


