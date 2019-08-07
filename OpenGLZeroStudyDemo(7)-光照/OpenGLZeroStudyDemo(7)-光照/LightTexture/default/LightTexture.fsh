precision mediump float;

uniform vec3 viewPos;

varying lowp vec3 normal;
varying lowp vec3 FragPos;

varying lowp vec2 v_texture;
uniform sampler2D  u_samplers2D[1];

void main(){
    // 环境光
    vec4 textureColor = texture2D(u_samplers2D[0],v_texture);
    gl_FragColor = textureColor;

}


