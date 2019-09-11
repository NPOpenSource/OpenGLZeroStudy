precision mediump float;
varying vec2 vTexCoords;
uniform sampler2D uTexture; // 立方体贴图的纹理采样器

void main()
{
//    textureCube(envMap, reflectVec)
    vec4 textureColor = texture2D(uTexture, vTexCoords);
    gl_FragColor = textureColor;
}

