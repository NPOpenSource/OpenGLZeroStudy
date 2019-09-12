//
//  GLFragCoordBindObject.m
//  OpenGLZeroStudyDemo(15)-高级Opengl-高级数据和高级glsl
//
//  Created by glodon on 2019/9/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLFragCoordBindObject.h"

@implementation GLFragCoordBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, FC_aPos, "aPos");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[FC_uniform_model] = glGetUniformLocation(program, "model");
    self->uniforms[FC_uniform_view] = glGetUniformLocation(program, "view");
    self->uniforms[FC_uniform_projection] = glGetUniformLocation(program, "projection");
    self->uniforms[FC_uniform_screenWidth] = glGetUniformLocation(program, "screenWidth");

    
}
-(NSString *)getShaderName{
    return @"GLFragCoord";
}

@end
