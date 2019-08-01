attribute vec3 beginPostion; ///开始位置
attribute float p_diameter;  ///点的直径
attribute vec3 gravity;
attribute float lifeTime; ///每个顶点的显示声明周期

uniform vec3 force;///力
uniform vec3  beginVelocity;  //速度s =s+vt;
uniform  float beginTime;  //开始时间 为了顶点不变,因此定时更新begin时间 .也可以设置成属性(这样就要更改顶点数据)
uniform  float currentTime;  //当前时间
uniform highp mat4  u_mvpMatrix; //mvp 眼的位置在0,0,1 看向0.0,0, 眼的正方向(法向量)是y轴,0,1,0; 看的空间在 0.1 ~ 20 之间

varying lowp float      v_particleOpacity; //粒子 不透明度

void main(){
    ///加速度  时间  和速度的关系 v= v0+at; 这里加速度是恒定的值。
    ///所以距离是 s = s0+(v+v0)/2*t= s0+(vo+at+v0)/2*t = s0+(2v0+at)/2*t
    ///= s0+vot+at^2/2
    float t =currentTime-beginTime;
    vec3 forceAll =gravity+force;
    highp vec3 currentPostion = beginPostion + beginVelocity * t+forceAll*t*t/2.0;
    gl_Position =u_mvpMatrix * vec4(currentPostion, 1.0);
    gl_PointSize =p_diameter / gl_Position.w;
    
    if (t>lifeTime) {
//        不显示
        v_particleOpacity = 0.0;
    }else{
        v_particleOpacity =(lifeTime-t)/lifeTime;
    }
    
}
