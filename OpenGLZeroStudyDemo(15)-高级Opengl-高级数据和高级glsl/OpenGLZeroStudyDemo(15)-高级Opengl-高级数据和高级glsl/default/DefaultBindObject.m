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
    glBindAttribLocation(program, DF_aTexCoords, "texture");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[DF_uniform_MVPMatrix] = glGetUniformLocation(program, "u_mvpMatrix");
    self->uniforms[DF_uniform_Samplers2D] = glGetUniformLocation(program, "u_samplers2D");
    self->uniforms[DF_uniform_AmbientLight] = glGetUniformLocation(program, "ambientLight");
}
-(NSString *)getShaderName{
    return @"Default";
}

@end
