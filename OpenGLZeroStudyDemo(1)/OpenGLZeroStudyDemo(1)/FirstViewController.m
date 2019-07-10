//
//  FirstViewController.m
//  OpenGLZeroStudyDemo(1)
//
//  Created by glodon on 2019/7/9.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "FirstViewController.h"
#import "OpenGLUtilsHeader.h"
@interface FirstViewController ()
@property (nonatomic ,strong) EAGLContext * eagcontext;
@property (nonatomic ,assign) GLuint  program;
@property (nonatomic ,strong) Shader * shader ;
@property (nonatomic ,assign) GLint vertexcolor;
@property (nonatomic ,strong) Vertex * vertex ;
@end

@implementation FirstViewController



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
                glBindAttribLocation(program, 0, "position");  // 0代表枚举位置
                _vertexcolor =  glGetUniformLocation(program, "color");
    }];

}

-(void)loadVertex{
    self.vertex = [Vertex new];
    [self.vertex allocVertexNum:3 andEachVertexNum:2];
    CGFloat vertex[2];
    vertex[0]=1;
    vertex[1]=1;
    [self.vertex setVertex:vertex index:0];
    vertex[0]=0;
    vertex[1]=1;
    [self.vertex setVertex:vertex index:1];
    vertex[0]=0;
    vertex[1]=0;
    [self.vertex setVertex:vertex index:2];
    
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertex enableVertexInVertexAttrib:GLKVertexAttribPosition numberOfCoordinates:2 attribOffset:0];
    
}




-(void)viewDidLoad{
    [super viewDidLoad];
    [self createEagContext];
    [self configure];
    [self createShader];
    [self loadVertex];
    
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    static NSInteger count = 0;
    // 清除颜色缓冲区
    glClearColor(1, 1, 1, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    count ++;
    if (count > 50 ) {
        count = 0;
        // 根据颜色索引值,设置颜色数据，就是刚才我们从着色器程序中获取的颜色索引值
        glUniform4f(_vertexcolor,   arc4random_uniform(255)/225.0, arc4random_uniform(255)/225.0, arc4random_uniform(255)/225.0, 1);
    }
    // 使用着色器程序
    glUseProgram(self.shader.program);
    // 绘制
    [self.vertex drawVertexWithMode:GL_TRIANGLES startVertexIndex:0 numberOfVertices:3];
}



@end
