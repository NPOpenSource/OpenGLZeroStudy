//
//  ShadowDepthBindObject.m
//  OpenGLZeroStudyDemo(18)-高级光照之阴影
//
//  Created by glodon on 2019/10/17.
//  Copyright © 2019 persion. All rights reserved.
//

#import "ShadowDepthBindObject.h"

@implementation ShadowDepthBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, SDD_aPos, "aPos");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[SDD_uniform_lightSpaceMatrix] = glGetUniformLocation(program, "uLightSpaceMatrix");
    self->uniforms[SDD_uniform_model] = glGetUniformLocation(program, "uModel");
}
-(NSString *)getShaderName{
    return @"ShadowDepth";
}
@end
