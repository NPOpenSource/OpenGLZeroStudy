//
//  AssimpViewController.m
//  OpenGLZeroStudyDemo(8)-Assimp(模型加载
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "AssimpViewController.h"
#import "AssimpBindObject.h"
#import "AssimpParse.h"


@interface AssimpViewController ()
@property (nonatomic ,strong) AssimpParse * assimpParse ;
@end


@implementation AssimpViewController

-(void)initSubObject{
    //生命周期三秒钟
    self.bindObject = [AssimpBindObject new];
    self.assimpParse = [ AssimpParse new];
}

-(void)loadVertex{
    [self.assimpParse parse];
}


-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
    glClearColor(1, 1, 1, 1);
    static GLfloat angle=0;
    angle ++ ;
    //    angle = 45;
    GLKMatrix4 mode =GLKMatrix4MakeRotation(angle*M_PI/180, 0, 1, 0);
    float scale = 0.2;
    mode = GLKMatrix4Scale(mode, scale, scale, scale);
    mode = GLKMatrix4Translate(mode, 0, -5, 0);
    glUniformMatrix4fv(self.bindObject->uniforms[uniform_model], 1, 0,mode.m);
    
    GLKMatrix4 viewMatrix =
    GLKMatrix4MakeLookAt(
                         0.0, 0.0, 5.0,   // Eye position
                         0.0, 0.0, 0.0,   // Look-at position
                         0.0, 1.0, 0.0);  // Up direction
    glUniformMatrix4fv(self.bindObject->uniforms[uniform_view], 1, 0,viewMatrix.m);
    
    GLfloat aspectRatio= CGRectGetWidth([UIScreen mainScreen].bounds) / CGRectGetHeight([UIScreen mainScreen].bounds);
    GLKMatrix4 projectionMatrix =
    GLKMatrix4MakePerspective(
                              GLKMathDegreesToRadians(85.0f),
                              aspectRatio,
                              0.1f,
                              20.0f);
    glUniformMatrix4fv(self.bindObject->uniforms[uniform_projection], 1, 0,projectionMatrix.m);

    [self.assimpParse draw:self.bindObject];

}


@end
