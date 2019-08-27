//
//  FaceCullingOrderFrontBindObject.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "FaceCullingOrderFrontBindObject.h"

@implementation FaceCullingOrderFrontBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, FCOF_aPos, "aPos");
    glBindAttribLocation(program, FCOF_aTexCoords, "aTexCoords");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[FCOF_uniform_model] = glGetUniformLocation(program, "model");
    self->uniforms[FCOF_uniform_view] = glGetUniformLocation(program, "view");
    self->uniforms[FCOF_uniform_projection] = glGetUniformLocation(program, "projection");
    self->uniforms[FCOF_uniform_Texture] = glGetUniformLocation(program, "uTexture");
}
-(NSString *)getShaderName{
    return @"FaceCullingOrderFront";
}

@end
