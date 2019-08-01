//
//  OneObjectGravityViewController.m
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/29.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "OneObjectGravityViewController.h"
#import "OneObjectGravityBindObject.h"
@interface OneObjectGravityViewController ()
@property (nonatomic ,assign) float timeInterval ;

@end

@implementation OneObjectGravityViewController

- (void)viewDidLoad{
    [super viewDidLoad];

}

-(void)initSubObject{
    __weakSelf
    self.bindObject = [OneObjectGravityBindObject new];
    self.bindObject.uniformSetterBlock = ^(GLuint program) {
        weakSelf.bindObject->uniforms[OneObjectGravityUniformLocationTimeInterval] =  glGetUniformLocation(program, "timeInterval");
        weakSelf.bindObject->uniforms[OneObjectGravityUniformLocationGravity] =  glGetUniformLocation(program, "u_gravity");
    };
}

-(void)loadVertex{
    self.vertex = [Vertex new];
    int vertexWidth = sizeof(OneObjectGravityBindAttrib)/sizeof(float);
    [self.vertex allocVertexNum:1 andEachVertexNum:vertexWidth];
    OneObjectGravityBindAttrib oneVertex;
    oneVertex.baseBindAttrib.beginPosition = GLKVector3Make(0, 0, 0);
    oneVertex.baseBindAttrib.p_diameter = 140;
    oneVertex.beginVelocity = GLKVector3Make(0, 2, 2);
    [self.vertex setVertex:oneVertex.t index:0];
    
    [self.vertex bindBufferWithUsage:GL_STATIC_DRAW];
    [self.vertex enableVertexInVertexAttrib:BeginPosition numberOfCoordinates:sizeof(oneVertex.baseBindAttrib.beginPosition)/sizeof(float) attribOffset:0];
    [self.vertex enableVertexInVertexAttrib:p_diameter numberOfCoordinates:sizeof(oneVertex.baseBindAttrib.p_diameter)/sizeof(float) attribOffset:sizeof(oneVertex.baseBindAttrib.beginPosition)];
    [self.vertex enableVertexInVertexAttrib:OneObjectGravityBindAttribLocationBeginVelocity numberOfCoordinates:sizeof(oneVertex.beginVelocity)/sizeof(float) attribOffset:sizeof(oneVertex.baseBindAttrib)];
}

-(void)update{
    NSLog(@"%lf",self.timeSinceFirstResume);
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [super glkView:view drawInRect:rect];
    self.timeInterval +=self.timeSinceLastUpdate;
    glUniform1f(self.bindObject->uniforms[OneObjectGravityUniformLocationTimeInterval] ,_timeInterval);
    GLKVector3 gravity =   GLKVector3Make(0, -9.8, 0);
    glUniform3fv(self.bindObject->uniforms[OneObjectGravityUniformLocationGravity], 1,gravity.v);
    [self.vertex drawVertexWithMode:GL_POINTS startVertexIndex:0 numberOfVertices:1];
}



@end
