attribute vec3 beginPostion; ///开始位置
attribute vec2 texture;

uniform mat4 u_mvpMatrix;

varying lowp vec2 vary_texture;

void main(){
    gl_Position =u_mvpMatrix * vec4(beginPostion, 1.0);
    vary_texture  = texture;

}
