precision mediump float;

uniform vec3 viewPos;

varying lowp vec3 normal;
varying lowp vec3 FragPos;

varying lowp vec2 v_texture;

struct Light{
    vec3 position;
    vec3 direction;
    float cutOff;
    float outerCutOff;
    
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

void main()
{
        // ambient
        vec3 ambient = light.ambient * texture2D(material.diffuse, v_texture).rgb;
        
        // diffuse
        vec3 norm = normalize(normal);
        vec3 lightDir = normalize(light.position - FragPos);
        float diff = max(dot(norm, lightDir), 0.0);
        vec3 diffuse = light.diffuse * diff * texture2D(material.diffuse, v_texture).rgb;
        
        // specular
        vec3 viewDir = normalize(viewPos - FragPos);
        vec3 reflectDir = reflect(-lightDir, norm);
        float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
        vec3 specular = light.specular * spec * texture2D(material.specular, v_texture).rgb;
        
        
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
        
        vec3 result = ambient + diffuse + specular;
        gl_FragColor = vec4(result, 1.0);
   
}
