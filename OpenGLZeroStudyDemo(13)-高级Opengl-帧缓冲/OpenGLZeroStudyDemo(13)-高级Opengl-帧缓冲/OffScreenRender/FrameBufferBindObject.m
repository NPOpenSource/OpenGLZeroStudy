//
//  FrameBufferBindObject.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "FrameBufferBindObject.h"

@implementation FrameBufferBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, FB_aPos, "aPos");
    glBindAttribLocation(program, FB_aTexCoords, "aTexCoords");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[FB_uniform_Texture] = glGetUniformLocation(program, "uTexture");
}
-(NSString *)getShaderName{
    return @"FrameBuffer";
}

@end
