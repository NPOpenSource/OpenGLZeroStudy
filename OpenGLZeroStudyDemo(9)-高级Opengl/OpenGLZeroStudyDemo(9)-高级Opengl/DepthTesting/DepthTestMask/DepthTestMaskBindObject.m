//
//  DepthTestMaskBindObject.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/19.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "DepthTestMaskBindObject.h"

@implementation DepthTestMaskBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, DTM_aPos, "aPos");
    glBindAttribLocation(program, DTM_aTexture, "aTexture");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[DTM_uniform_model] = glGetUniformLocation(program, "model");
    self->uniforms[DTM_uniform_view] = glGetUniformLocation(program, "view");
    self->uniforms[DTM_uniform_projection] = glGetUniformLocation(program, "projection");
    self->uniforms[DTM_uniform_sam2D] = glGetUniformLocation(program, "sam2D");
}

-(NSString *)getShaderName{
    return @"DepthTestMask";
}
@end
