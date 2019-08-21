
//
//  DepthTestIsOpenBindObject.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "DepthTestIsOpenBindObject.h"

@implementation DepthTestIsOpenBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, DTIO_aPos, "aPos");
    glBindAttribLocation(program, DTIO_aColor, "aColor");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[DTIO_uniform_model] = glGetUniformLocation(program, "model");
    self->uniforms[DTIO_uniform_view] = glGetUniformLocation(program, "view");
    self->uniforms[DTIO_uniform_projection] = glGetUniformLocation(program, "projection");
}
-(NSString *)getShaderName{
    return @"DepthTestIsOpen";
}
@end
