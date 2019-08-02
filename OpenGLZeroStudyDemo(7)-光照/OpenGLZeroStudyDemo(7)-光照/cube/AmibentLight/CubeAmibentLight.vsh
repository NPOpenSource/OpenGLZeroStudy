attribute vec3 beginPostion; ///开始位置
attribute vec3 vertexColor;
uniform mat4 u_mvpMatrix;

varying lowp vec3 vary_vertexColor;

void main(){
    gl_Position =u_mvpMatrix * vec4(beginPostion, 1.0);
    vary_vertexColor  = vertexColor;

}
