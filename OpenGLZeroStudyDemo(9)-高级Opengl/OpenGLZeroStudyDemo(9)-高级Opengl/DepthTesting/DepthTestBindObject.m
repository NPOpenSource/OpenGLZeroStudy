//
//  DepthTestBindObject.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "DepthTestBindObject.h"

@implementation DepthTestBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, DT_aPos, "aPos");
    glBindAttribLocation(program, DT_aTexCoords, "aTexCoords");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[DT_uniform_model] = glGetUniformLocation(program, "model");
    self->uniforms[DT_uniform_view] = glGetUniformLocation(program, "view");
    self->uniforms[DT_uniform_projection] = glGetUniformLocation(program, "projection");
    self->uniforms[DT_uniform_Texture] = glGetUniformLocation(program, "uTexture");
}
-(NSString *)getShaderName{
    return @"DepthTest";
}

@end
