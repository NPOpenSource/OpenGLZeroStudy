attribute vec3 beginPostion; ///开始位置
attribute float p_diameter;  ///点的直径
attribute vec3  beginVelocity;  //速度s =s+vt;

uniform vec3 u_gravity;  //重力 (0,-9.8,0)
uniform  float timeInterval;  //间隔
uniform highp mat4  u_mvpMatrix; //mvp 眼的位置在0,0,1 看向0.0,0, 眼的正方向(法向量)是y轴,0,1,0; 看的空间在 0.1 ~ 20 之间
void main(){
    ///加速度  时间  和速度的关系 v= v0+at; 这里加速度是恒定的值。
    ///所以距离是 s = s0+(v+v0)/2*t= s0+(vo+at+v0)/2*t = s0+(2v0+at)/2*t
    ///= s0+vot+at^2/2
    
    highp vec3 currentPostion = beginPostion + beginVelocity * timeInterval+u_gravity*timeInterval*timeInterval/2.0;

    gl_Position =u_mvpMatrix * vec4(currentPostion, 1.0);
    gl_PointSize =p_diameter / gl_Position.w;
}
