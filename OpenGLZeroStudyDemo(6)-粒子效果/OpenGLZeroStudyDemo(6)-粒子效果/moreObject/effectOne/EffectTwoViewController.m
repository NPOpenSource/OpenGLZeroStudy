//
//  EffectTwoViewController.m
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/30.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "EffectTwoViewController.h"
#import "MoreObjectBindObject.h"
#import "EffectVertex.h"

@interface EffectTwoViewController ()
@property (nonatomic ,assign) NSTimeInterval currentTime ;
///生成顶点间隔
@property (nonatomic ,assign) NSTimeInterval eachInterval ;
@property (nonatomic ,assign) NSTimeInterval lastIntervalTime ;
@property (nonatomic ,strong) NSMutableArray * cacheVertexArr ;
@end

@implementation EffectTwoViewController

-(void)initSubObject{
    self.cacheVertexArr = [NSMutableArray array];
    self.eachInterval = 0.5f;
    //生命周期三秒钟
    __weakSelf
    self.bindObject = [MoreObjectBindObject new];
    self.bindObject.uniformSetterBlock = ^(GLuint program) {
        weakSelf.bindObject->uniforms[MoreObjectUniformLocationBeginTime] =  glGetUniformLocation(program, "beginTime");
        weakSelf.bindObject->uniforms[MoreObjectUniformLocationCurrentTime] =  glGetUniformLocation(program, "currentTime");
        weakSelf.bindObject->uniforms[MoreObjectUniformLocationBeginVelocity] =  glGetUniformLocation(program, "beginVelocity");
        weakSelf.bindObject->uniforms[MoreObjectUniformLocationForce] =  glGetUniformLocation(program, "force");
    };
}

-(void)loadVertex{
    [self createVertex];
    
}

-(void)updateVertexForce:(EffectVertex *)vertex{
    vertex.force = GLKVector3Make( 0
                                  , 0, 0);
    vertex.beginTime = self.currentTime;
    float randomXVelocity = -0.5f + 1.0f *
    (float)random() / (float)RAND_MAX;
    float randomYVelocity = -0.5f + 1.0f *
    (float)random() / (float)RAND_MAX;
    float randomZVelocity = -0.5f + 1.0f *
    (float)random() / (float)RAND_MAX;
    vertex.beginVelocity = GLKVector3Make(randomXVelocity,
                                          randomYVelocity,
                                          randomZVelocity);
}

-(void)createVertex{
    for(int i = 0; i <100; i++)
    {
        EffectVertex * ver =nil;
        if (self.cacheVertexArr.count!=0) {
            ver =[self.cacheVertexArr objectAtIndex:0];
            [self.cacheVertexArr removeObjectAtIndex:0];
        }
        if (!ver) {
            ver =[EffectVertex new];
        }
        int vertexWidth = sizeof(OneObjectEdgeCheckBindAttrib)/sizeof(float);
        [ver allocVertexNum:1 andEachVertexNum:vertexWidth];
        OneObjectEdgeCheckBindAttrib bindAtt ;
        bindAtt.baseBindAttrib.beginPosition =GLKVector3Make(0.0f, 0.0, 0.0);
        bindAtt.baseBindAttrib.p_diameter = 8.0;
        bindAtt.gravity = GLKVector3Make(0, 0, 0);
        bindAtt.lifeTime = 3.2;
        [ver setVertex:bindAtt.t index:0];
        
        [ver bindBufferWithUsage:GL_STATIC_DRAW];
        [ver enableVertexInVertexAttrib:BeginPosition numberOfCoordinates:sizeof(bindAtt.baseBindAttrib.beginPosition)/sizeof(float) attribOffset:0];
        [ver enableVertexInVertexAttrib:p_diameter numberOfCoordinates:sizeof(bindAtt.baseBindAttrib.p_diameter)/sizeof(float) attribOffset:sizeof(bindAtt.baseBindAttrib.beginPosition)];
        [ver enableVertexInVertexAttrib:MoreObjectBindAttribLocationGravity numberOfCoordinates:sizeof(bindAtt.gravity)/sizeof(float) attribOffset:sizeof(bindAtt.baseBindAttrib)];
        [ver enableVertexInVertexAttrib:MoreObjectBindAttribLocationLifeTime numberOfCoordinates:sizeof(bindAtt.lifeTime)/sizeof(float) attribOffset:sizeof(bindAtt.baseBindAttrib)+sizeof(bindAtt.gravity)];
        [self updateVertexForce:ver];
        [self.vertexArr addObject:ver];
    }
}

-(void)update{
    self.currentTime +=self.timeSinceLastDraw;
    if (self.lastIntervalTime<self.currentTime-self.eachInterval) {
        self.lastIntervalTime = self.currentTime;
        [self createVertex];
    }
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [super glkView:view drawInRect:rect];
    //
    glUniform1f(self.bindObject->uniforms[MoreObjectUniformLocationCurrentTime] ,_currentTime);
  
    NSMutableArray * temp = [NSMutableArray array];
    for (EffectVertex * vertex in self.vertexArr) {
        glUniform3fv(self.bindObject->uniforms[MoreObjectUniformLocationForce], 1,vertex.force.v);
        glUniform1f(self.bindObject->uniforms[MoreObjectUniformLocationBeginTime] ,vertex.beginTime);
        glUniform3fv(self.bindObject->uniforms[MoreObjectUniformLocationBeginVelocity], 1,vertex.beginVelocity.v);
        if (self.currentTime-vertex.beginTime>2.2) {
            [temp addObject:vertex];
        }else{
            glDepthMask(GL_FALSE);  // Disable depth buffer writes
            [vertex drawVertexWithMode:GL_POINTS startVertexIndex:0 numberOfVertices:1];
            glDepthMask(GL_TRUE);  // Reenable depth buffer writes
        }
    }
    [self.vertexArr removeObjectsInArray:temp];
    [self.cacheVertexArr addObjectsFromArray:temp];
}


@end
