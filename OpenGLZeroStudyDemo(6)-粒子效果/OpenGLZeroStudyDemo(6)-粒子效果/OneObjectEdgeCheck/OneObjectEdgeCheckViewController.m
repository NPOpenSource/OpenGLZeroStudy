//
//  OneObjectEdgeCheckViewController.m
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/30.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "OneObjectEdgeCheckViewController.h"
#import "OneObjectEdgeCheck.h"
@interface OneObjectEdgeCheckViewController ()
@property (nonatomic ,assign) float timeInterval ;
@property (nonatomic ,assign) float beginTime ;
@end

@implementation OneObjectEdgeCheckViewController
-(void)initSubObject{
    __weakSelf
    self.bindObject = [OneObjectEdgeCheck new];
    self.bindObject.uniformSetterBlock = ^(GLuint program) {
        weakSelf.bindObject->uniforms[OneObjectEdgeCheckUniformLocationTimeInterval] =  glGetUniformLocation(program, "timeInterval");
        weakSelf.bindObject->uniforms[OneObjectEdgeCheckUniformLocationGravity] =  glGetUniformLocation(program, "u_gravity");
         weakSelf.bindObject->uniforms[OneObjectEdgeCheckUniformLocationBeginTime] =  glGetUniformLocation(program, "beginTime");
    };
}

-(void)loadVertex{
    self.vertex = [Vertex new];
    int vertexWidth = sizeof(OneObjectEdgeCheckBindAttrib)/sizeof(float);
    [self.vertex allocVertexNum:1 andEachVertexNum:vertexWidth];
   OneObjectEdgeCheckBindAttrib oneVertex;
    oneVertex.baseBindAttrib.beginPosition = GLKVector3Make(0, 1, 0);
    oneVertex.baseBindAttrib.p_diameter = 40;
    oneVertex.beginVelocity = GLKVector3Make(0, 0, 0);
    [self.vertex setVertex:oneVertex.t index:0];
    
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertex enableVertexInVertexAttrib:BeginPosition numberOfCoordinates:sizeof(oneVertex.baseBindAttrib.beginPosition)/sizeof(float) attribOffset:0];
    [self.vertex enableVertexInVertexAttrib:p_diameter numberOfCoordinates:sizeof(oneVertex.baseBindAttrib.p_diameter)/sizeof(float) attribOffset:sizeof(oneVertex.baseBindAttrib.beginPosition)];
    [self.vertex enableVertexInVertexAttrib:OneObjectEdgeCheckBindAttribLocationBeginVelocity numberOfCoordinates:sizeof(oneVertex.beginVelocity)/sizeof(float) attribOffset:sizeof(oneVertex.baseBindAttrib)];
}


-(void)update{
    self.timeInterval +=self.timeSinceLastDraw/3;
    if (self.beginTime<self.timeInterval-1) {
        self.beginTime = self.timeInterval;
    }
}


-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [super glkView:view drawInRect:rect];
   
     glUniform1f(self.bindObject->uniforms[OneObjectEdgeCheckUniformLocationBeginTime] ,_beginTime);
    glUniform1f(self.bindObject->uniforms[OneObjectEdgeCheckUniformLocationTimeInterval] ,_timeInterval);
    GLKVector3 gravity =   GLKVector3Make(0, -9.8, 0);
    glUniform3fv(self.bindObject->uniforms[OneObjectEdgeCheckUniformLocationGravity], 1,gravity.v);
    [self.vertex drawVertexWithMode:GL_POINTS startVertexIndex:0 numberOfVertices:1];
}



@end
