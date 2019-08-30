//
//  DefaultRenderBindObject.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "DefaultRenderBindObject.h"

@implementation DefaultRenderBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, DR_aPos, "aPos");
    glBindAttribLocation(program, DR_aTexCoords, "aTexCoords");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[DR_uniform_model] = glGetUniformLocation(program, "model");
    self->uniforms[DR_uniform_view] = glGetUniformLocation(program, "view");
    self->uniforms[DR_uniform_projection] = glGetUniformLocation(program, "projection");
    self->uniforms[DR_uniform_Texture] = glGetUniformLocation(program, "uTexture");
}
-(NSString *)getShaderName{
    return @"DefaultRender";
}

@end
