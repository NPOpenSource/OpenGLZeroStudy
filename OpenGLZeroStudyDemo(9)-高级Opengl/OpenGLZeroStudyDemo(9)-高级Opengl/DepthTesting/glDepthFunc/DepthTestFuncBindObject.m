//
//  DepthTestFuncBindObject.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/20.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "DepthTestFuncBindObject.h"

@implementation DepthTestFuncBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, DTF_aPos, "aPos");
    glBindAttribLocation(program, DTF_aTexture, "aTexture");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[DTF_uniform_model] = glGetUniformLocation(program, "model");
    self->uniforms[DTF_uniform_view] = glGetUniformLocation(program, "view");
    self->uniforms[DTF_uniform_projection] = glGetUniformLocation(program, "projection");
    self->uniforms[DTF_uniform_sam2D] = glGetUniformLocation(program, "sam2D");
}

-(NSString *)getShaderName{
    return @"DepthTestFunc";
}
@end
