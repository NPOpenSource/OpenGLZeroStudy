//
//  GLPointBindObject.m
//  OpenGLZeroStudyDemo(15)-高级Opengl-高级数据和高级glsl
//
//  Created by glodon on 2019/9/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLPointBindObject.h"

@implementation GLPointBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, PT_aPos, "beginPostion");
}
-(void)setUniformLocation:(GLuint)program{
    self->uniforms[PT_uniform_MVPMatrix] = glGetUniformLocation(program, "u_mvpMatrix");

}
-(NSString *)getShaderName{
    return @"GLPoint";
}
@end
