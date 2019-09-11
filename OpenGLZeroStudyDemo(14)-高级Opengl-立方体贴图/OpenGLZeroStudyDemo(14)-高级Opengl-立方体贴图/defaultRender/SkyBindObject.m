//
//  SkyBindObject.m
//  OpenGLZeroStudyDemo(14)-高级Opengl-立方体贴图
//
//  Created by glodon on 2019/9/2.
//  Copyright © 2019 openSource. All rights reserved.
//

#import "SkyBindObject.h"

@implementation SkyBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, SKB_aPos, "aPos");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[SKB_uniform_view] = glGetUniformLocation(program, "view");
    self->uniforms[SKB_uniform_projection] = glGetUniformLocation(program, "projection");
    self->uniforms[SKB_uniform_Texture] = glGetUniformLocation(program, "cubemap");
}
-(NSString *)getShaderName{
    return @"skybox";
}
@end
