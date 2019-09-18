//
//  PhoneLightingBindObject.m
//  OpenGLZeroStudyDemo(17)-高级光照之高级光照
//
//  Created by glodon on 2019/9/18.
//  Copyright © 2019 persion. All rights reserved.
//

#import "PhoneLightingBindObject.h"

@implementation PhoneLightingBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, PL_aPos, "aPos");
    glBindAttribLocation(program, PL_aNormal, "aNormal");
    glBindAttribLocation(program, PL_aTexCoords, "aTexCoords");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[PL_uniform_projection] = glGetUniformLocation(program, "uProjection");
    self->uniforms[PL_uniform_view] = glGetUniformLocation(program, "uView");
    self->uniforms[PL_uniform_floorTexture] = glGetUniformLocation(program, "uFloorTexture");
    self->uniforms[PL_uniform_lightPos] = glGetUniformLocation(program, "uLightPos");
    self->uniforms[PL_uniform_viewPos] = glGetUniformLocation(program, "uViewPos");
    self->uniforms[PL_uniform_blinn] = glGetUniformLocation(program, "uBlinn");

    
}
-(NSString *)getShaderName{
    return @"PhoneLighting";
}

@end
