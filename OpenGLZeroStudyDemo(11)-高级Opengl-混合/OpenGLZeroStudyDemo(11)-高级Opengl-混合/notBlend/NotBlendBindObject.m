//
//  NotBlendBindObject.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "NotBlendBindObject.h"

@implementation NotBlendBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, NST_aPos, "aPos");
    glBindAttribLocation(program, NST_aTexCoords, "aTexCoords");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[NST_uniform_model] = glGetUniformLocation(program, "model");
    self->uniforms[NST_uniform_view] = glGetUniformLocation(program, "view");
    self->uniforms[NST_uniform_projection] = glGetUniformLocation(program, "projection");
    self->uniforms[NST_uniform_Texture] = glGetUniformLocation(program, "uTexture");
}
-(NSString *)getShaderName{
    return @"NotBlend";
}

@end
