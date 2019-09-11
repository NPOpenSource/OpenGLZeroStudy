precision mediump float;
varying vec3 vTexCoords;
uniform samplerCube  cubemap; // 立方体贴图的纹理采样器

void main()
{
//    textureCube(envMap, reflectVec)
    vec4 textureColor = textureCube(cubemap, vTexCoords);
    gl_FragColor = textureColor;
}

