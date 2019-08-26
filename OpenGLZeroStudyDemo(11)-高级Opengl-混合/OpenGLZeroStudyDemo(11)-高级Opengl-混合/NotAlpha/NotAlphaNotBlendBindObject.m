//
//  NotAlphaNotBlendBindObject.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "NotAlphaNotBlendBindObject.h"

@implementation NotAlphaNotBlendBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, NANST_aPos, "aPos");
    glBindAttribLocation(program, NANST_aTexCoords, "aTexCoords");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[NANST_uniform_model] = glGetUniformLocation(program, "model");
    self->uniforms[NANST_uniform_view] = glGetUniformLocation(program, "view");
    self->uniforms[NANST_uniform_projection] = glGetUniformLocation(program, "projection");
    self->uniforms[NANST_uniform_Texture] = glGetUniformLocation(program, "uTexture");
}
-(NSString *)getShaderName{
    return @"NotAlphaNotBlend";
}

@end
