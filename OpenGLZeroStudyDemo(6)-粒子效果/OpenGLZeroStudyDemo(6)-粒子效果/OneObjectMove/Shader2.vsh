attribute vec3 beginPostion; ///开始位置
attribute float p_diameter;  ///点的直径
attribute vec3  beginVelocity;  //速度s = vt;
uniform  float timeInterval;  //间隔
uniform highp mat4      u_mvpMatrix; //mvp 眼的位置在0,0,1 看向0.0,0, 眼的正方向(法向量)是y轴,0,1,0; 看的空间在 0.1 ~ 20 之间
void main(){
    highp vec3 currentPostion = beginPostion + beginVelocity * timeInterval;
    gl_Position =u_mvpMatrix * vec4(currentPostion, 1.0);
//    使用顶点的w分量作为当前点与视点间的距离
//   之前，我们并未显示使用过gl_Position的w分量，实际上，这个w分量的值就是顶点的视图坐标的z分量乘以-1。在视图坐标系中，视点在原点，视线沿着Z轴负方向，观察者看到的物体其视图坐标系值z分量都是负的，而gl_Position的w分量正好是z分量值乘以-1，所以可以直接使用该值来近似顶点和视点建的距离。
    gl_PointSize =p_diameter / gl_Position.w;
}
