//
//  GLBaseBindObject.m
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/29.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseBindObject.h"

@implementation GLBaseBindObject

-(void)setUniformLocation:(void(^)(void))uniformSetterblock{
    if (uniformSetterblock) {
        uniformSetterblock();
    }
}

-(void)BindAttribLocation:(GLuint) program{
    glBindAttribLocation(program, BeginPosition, "beginPostion");
}
-(NSString *)getShaderName{
    return nil;
}

@end
