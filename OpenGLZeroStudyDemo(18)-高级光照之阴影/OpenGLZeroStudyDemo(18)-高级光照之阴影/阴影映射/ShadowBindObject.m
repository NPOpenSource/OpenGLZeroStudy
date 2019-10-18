//
//  ShadowBindObject.m
//  OpenGLZeroStudyDemo(18)-高级光照之阴影
//
//  Created by glodon on 2019/10/17.
//  Copyright © 2019 persion. All rights reserved.
//

#import "ShadowBindObject.h"

@implementation ShadowBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, SD_aPos, "aPos");
    glBindAttribLocation(program, SD_aTexCoords, "aTexCoords");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[SD_uniform_depthMap] = glGetUniformLocation(program, "uDepthMap");
    self->uniforms[SD_uniform_nearPlane] = glGetUniformLocation(program, "uNearPlane");
    self->uniforms[SD_uniform_farPlane] = glGetUniformLocation(program, "uFarPlane");
   
}
-(NSString *)getShaderName{
    return @"Shadow";
}

@end
