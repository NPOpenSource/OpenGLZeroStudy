//
//  ShaderViewController.m
//  OpenGLZeroStudyDemo(3)
//
//  Created by glodon on 2019/7/17.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "ShaderViewController.h"

@interface ShaderViewController ()
@property (nonatomic ,strong) UIViewController * tapVc;
@property (nonatomic ,strong) EAGLContext * eagcontext;
@property (nonatomic ,assign) GLuint  program;
@property (nonatomic ,strong) Shader * shader ;
@property (nonatomic ,assign) GLint vertexcolor;
@property (nonatomic ,strong) Vertex * vertex ;
@end

@implementation ShaderViewController

-(void)createEagContext{
    self.eagcontext = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:self.eagcontext];
}

-(void)configure{
    GLKView *view = (GLKView*)self.view;
    view.context = self.eagcontext;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
}

-(void)createShader{
    self.shader = [Shader new];
    [self.shader compileLinkSuccessShaderName:@"Shader" completeBlock:^(GLuint program) {
        glBindAttribLocation(program, GLKVertexAttribPosition, "position");  // 0代表枚举位置

    }];
    _vertexcolor =  glGetUniformLocation(self.shader.program, "color");

}


#define VertexNum 6
#define eachVertexNum 8
-(void)loadVertex{
    self.vertex = [Vertex new];
    [self.vertex allocVertexNum:VertexNum andEachVertexNum:eachVertexNum];
    GLfloat vertex[8];
    vertex[0]=0;
    vertex[1]=1.0;
    vertex[2]=0;
    vertex[3]=2.0;
    vertex[4]=1.0;
    vertex[5]=1.0;
    vertex[6]=0.0;
    vertex[7]=1.0;
    [self.vertex setVertex:vertex index:0];
    vertex[0]=-1;
    vertex[1]=0.3;
    [self.vertex setVertex:vertex index:1];
    vertex[0]=-1.0;
    vertex[1]=-0.3;
    [self.vertex setVertex:vertex index:2];
    vertex[0]=0;
    vertex[1]=-1.0;
    [self.vertex setVertex:vertex index:3];
    vertex[0]=1;
    vertex[1]=-0.3;
    [self.vertex setVertex:vertex index:4];
    vertex[0]=1;
    vertex[1]=0.3;
    [self.vertex setVertex:vertex index:5];
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertex enableVertexInVertexAttrib:0  numberOfCoordinates:4 attribOffset:0];
    [self.vertex enableVertexInVertexAttrib:1 numberOfCoordinates:4 attribOffset:4*sizeof(GLfloat)];
    
    
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    static NSInteger count = 0;
    // 清除颜色缓冲区
    glClearColor(1,1, 1, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    count ++;
    if (count > 50 ) {
        count = 0;
        // 根据颜色索引值,设置颜色数据，就是刚才我们从着色器程序中获取的颜色索引值
                glUniform4f(self.vertexcolor,   arc4random_uniform(255)/225.0, arc4random_uniform(255)/225.0, arc4random_uniform(255)/225.0, 1);
    }
    // 使用着色器程序
    glUseProgram(self.shader.program);
    // 绘制
    [self.vertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:VertexNum];
    
}




-(void)viewDidLoad{
    [super viewDidLoad];
    [self createEagContext];
    [self configure];
    [self createShader];
    [self loadVertex];
    
}



@end
