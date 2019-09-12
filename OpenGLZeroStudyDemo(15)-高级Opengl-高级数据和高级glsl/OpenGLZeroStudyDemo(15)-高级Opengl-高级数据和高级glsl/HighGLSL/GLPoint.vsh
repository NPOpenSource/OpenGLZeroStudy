attribute vec3 beginPostion; ///开始位置
uniform mat4 u_mvpMatrix;

void main(){
    gl_Position =u_mvpMatrix * vec4(beginPostion, 1.0);
    gl_PointSize =300.0/gl_Position.z;

}
