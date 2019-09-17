//
//  DefaultBindObject.m
//  OpenGLZeroStudyDemo(15)-高级Opengl-高级数据和高级glsl
//
//  Created by glodon on 2019/9/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "DefaultBindObject.h"

@implementation DefaultBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, DF_aPos, "beginPostion");
    glBindAttribLocation(program, DF_aColor, "color");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[DF_uniform_Offset] = glGetUniformLocation(program, "u_offset");
}
-(NSString *)getShaderName{
    return @"Default";
}

@end
