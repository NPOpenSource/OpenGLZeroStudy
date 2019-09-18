precision mediump float;

uniform sampler2D uFloorTexture;
uniform vec3 uLightPos;
uniform vec3 uViewPos;
uniform bool uBlinn;


varying  vec3 vFragPos;
varying  vec3 vNormal;
varying  vec2 vTexCoords;

void main()
{
    vec3 color = texture2D(uFloorTexture, vTexCoords).rgb;
    vec3 ambient = 0.05 * color;
    vec3 lightDir = normalize(uLightPos - vFragPos);
    vec3 normal = normalize(vNormal);
    float diff = max(dot(lightDir, normal), 0.0);
    vec3 diffuse = diff * color;
    vec3 viewDir = normalize(uViewPos - vFragPos);
    float spec = 0.0;

    if (uBlinn) {
        vec3 halfwayDir = normalize(lightDir + viewDir);
        spec = pow(max(dot(normal, halfwayDir), 0.0), 32.0);
    }else{
        vec3 reflectDir = reflect(-lightDir, normal);
        spec = pow(max(dot(viewDir, reflectDir), 0.0), 8.0);
    }

    vec3 specular = vec3(0.3) * spec; // assuming bright white light color

    gl_FragColor =  vec4(ambient + diffuse + specular, 1.0);
}
