//
//  OffScreenRenderBindObject.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "OffScreenRenderBindObject.h"

@implementation OffScreenRenderBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, OSR_aPos, "aPos");
    glBindAttribLocation(program, OSR_aTexCoords, "aTexCoords");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[OSR_uniform_model] = glGetUniformLocation(program, "model");
    self->uniforms[OSR_uniform_view] = glGetUniformLocation(program, "view");
    self->uniforms[OSR_uniform_projection] = glGetUniformLocation(program, "projection");
    self->uniforms[OSR_uniform_Texture] = glGetUniformLocation(program, "uTexture");
}
-(NSString *)getShaderName{
    return @"OffScreenRender";
}

@end
