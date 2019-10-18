precision mediump float;

uniform sampler2D uDepthMap;
uniform float uNearPlane;
uniform float uFarPlane;

varying  vec2 vTexCoords;

float LinearizeDepth(float depth)
{
    float z = depth * 2.0 - 1.0; // Back to NDC
    return (2.0 * uNearPlane * uFarPlane) / (uFarPlane + uNearPlane - z * (uFarPlane - uNearPlane));
}

void main()
{
    float depthValue = texture2D(uDepthMap, vTexCoords).r;
//    gl_FragColor =vec4(vec3(depthValue), 1.0);
     gl_FragColor = vec4(vec3(LinearizeDepth(depthValue) / uFarPlane), 1.0); // perspective

}

