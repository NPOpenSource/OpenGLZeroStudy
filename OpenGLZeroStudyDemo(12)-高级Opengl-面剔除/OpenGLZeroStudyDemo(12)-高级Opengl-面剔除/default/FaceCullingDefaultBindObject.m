//
//  FaceCullingDefaultBindObject.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "FaceCullingDefaultBindObject.h"

@implementation FaceCullingDefaultBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, FCD_aPos, "aPos");
    glBindAttribLocation(program, FCD_aTexCoords, "aTexCoords");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[FCD_uniform_model] = glGetUniformLocation(program, "model");
    self->uniforms[FCD_uniform_view] = glGetUniformLocation(program, "view");
    self->uniforms[FCD_uniform_projection] = glGetUniformLocation(program, "projection");
    self->uniforms[FCD_uniform_Texture] = glGetUniformLocation(program, "uTexture");
}
-(NSString *)getShaderName{
    return @"FaceCullingDefault";
}

@end
