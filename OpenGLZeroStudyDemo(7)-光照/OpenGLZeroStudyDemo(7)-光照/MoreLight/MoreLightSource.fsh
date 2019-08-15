precision mediump float;

struct Material{
    sampler2D diffuse;
    sampler2D specular;
    float shininess;
};

struct DirLight {
    vec3 direction;
    
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

struct PointLight {
    vec3 position;
    
    float constant;
    float linear;
    float quadratic;
    
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};


struct SpotLight {
    vec3 position;
    vec3 direction;
    float cutOff;
    float outerCutOff;
    
    float constant;
    float linear;
    float quadratic;
    
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

uniform vec3 viewPos;

uniform Material material;

uniform DirLight dirLight;
#define NR_POINT_LIGHTS 4
uniform PointLight pointLights[NR_POINT_LIGHTS];
uniform SpotLight spotLight;


varying lowp vec3 normal;
varying lowp vec3 FragPos;
varying lowp vec2 v_texture;

vec3 CalcDirLight(DirLight light, vec3 normal, vec3 viewDir);
vec3 CalcPointLight(PointLight light, vec3 normal, vec3 fragPos, vec3 viewDir);
vec3 CalcSpotLight(SpotLight light, vec3 normal, vec3 fragPos, vec3 viewDir);



void main()
{
    vec3 norm = normalize(normal);
    vec3 viewDir = normalize(viewPos - FragPos);
    vec3 result = vec3(0.0);
   ///平行光
     result += CalcDirLight(dirLight, norm, viewDir);
    // 点光源
    for(int i = 0; i < NR_POINT_LIGHTS; i++)
        result += CalcPointLight(pointLights[i], norm, FragPos, viewDir);
//     聚光
    result +=CalcSpotLight(spotLight, norm, FragPos, viewDir);;
//
    gl_FragColor = vec4(result, 1.0);
   
}


vec3 CalcDirLight(DirLight light, vec3 normal, vec3 viewDir)
{
    vec3 diffuseT =vec3(texture2D(material.diffuse,v_texture));
    vec3 specularT =vec3(texture2D(material.specular,v_texture));
    
    ///环境光
    vec3 ambient = light.ambient * diffuseT;
    
    // 漫反射
    vec3 lightDir = normalize(-light.direction);
    float diff = max(dot(normal, lightDir), 0.0);
    vec3 diffuse = light.diffuse * (diff * diffuseT);
    
    // 镜面光
    vec3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess*128.0);
    vec3 specular = light.specular * (spec * specularT);
    
    return( ambient + diffuse + specular);
}

vec3 CalcPointLight(PointLight light, vec3 normal, vec3 fragPos, vec3 viewDir)
{
    vec3 diffuseT =vec3(texture2D(material.diffuse,v_texture));
    vec3 specularT =vec3(texture2D(material.specular,v_texture));
    
    vec3 lightDir = normalize(light.position - FragPos);

    ///环境光
    vec3 ambient = light.ambient * diffuseT;
    
    // 漫反射
    float diff = max(dot(normal, lightDir), 0.0);
    vec3 diffuse = light.diffuse * (diff * diffuseT);
    
    // 镜面光
    vec3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess*128.0);
    vec3 specular = light.specular * (spec * specularT);
    
    
    float distance    = length(light.position - fragPos);
    float attenuation = 1.0 / (light.constant + light.linear * distance +
                               light.quadratic * (distance * distance));
    
    ambient  *= attenuation;
    diffuse   *= attenuation;
    specular *= attenuation;
    return (ambient + diffuse + specular);

}

vec3 CalcSpotLight(SpotLight light, vec3 normal, vec3 fragPos, vec3 viewDir)
{
    vec3 diffuseT =vec3(texture2D(material.diffuse,v_texture));
    vec3 specularT =vec3(texture2D(material.specular,v_texture));
    
    //环境光
    vec3 ambient = light.ambient * diffuseT;
    vec3 lightDir = normalize(light.position - FragPos);

    // 漫反射
    float diff = max(dot(normal, lightDir), 0.0);
    vec3 diffuse = light.diffuse * (diff * diffuseT);
    
    // 镜面光
    vec3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
    vec3 specular = light.specular * (spec * specularT);
    
    // spotlight (soft edges)
    float theta = dot(lightDir, normalize(-light.direction));
    float epsilon = (light.cutOff - light.outerCutOff);
    float intensity = clamp((theta - light.outerCutOff) / epsilon, 0.0, 1.0);
    diffuse  *= intensity;
    specular *= intensity;
    
    // attenuation
    float distance    = length(light.position - FragPos);
    float attenuation = 1.0 / (light.constant + light.linear * distance + light.quadratic * (distance * distance));
    
    // ambient  *= attenuation; // remove attenuation from ambient, as otherwise at large distances the light would be darker inside than outside the spotlight due the ambient term in the else branche
    diffuse   *= attenuation;
    specular *= attenuation;
    
    return (ambient + diffuse + specular);
}
