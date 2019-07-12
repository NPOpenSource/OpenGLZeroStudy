//
//  VertexDimViewController.m
//  OpenGLZeroStudyDemo(2)
//
//  Created by glodon on 2019/7/11.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "VertexDimViewController.h"


@interface VertexDimViewController ()

@end

@implementation VertexDimViewController



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


-(void)loadVertex{
   
    
}




-(void)viewDidLoad{
    [super viewDidLoad];
    [self createEagContext];
    [self configure];
    [self createShader];
    [self loadVertex];
    
}




@end
