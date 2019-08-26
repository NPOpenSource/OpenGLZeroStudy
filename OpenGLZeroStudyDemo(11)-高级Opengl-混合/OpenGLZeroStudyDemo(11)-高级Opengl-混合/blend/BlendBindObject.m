//
//  BlendBindObject.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "BlendBindObject.h"

@implementation BlendBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, ST_aPos, "aPos");
    glBindAttribLocation(program, ST_aTexCoords, "aTexCoords");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[ST_uniform_model] = glGetUniformLocation(program, "model");
    self->uniforms[ST_uniform_view] = glGetUniformLocation(program, "view");
    self->uniforms[ST_uniform_projection] = glGetUniformLocation(program, "projection");
    self->uniforms[ST_uniform_Texture] = glGetUniformLocation(program, "uTexture");
}
-(NSString *)getShaderName{
    return @"Blend";
}

@end
