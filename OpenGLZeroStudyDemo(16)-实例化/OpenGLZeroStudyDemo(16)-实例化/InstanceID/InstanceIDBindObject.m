//
//  InstanceIDBindObject.m
//  OpenGLZeroStudyDemo(15)-高级Opengl-高级数据和高级glsl
//
//  Created by glodon on 2019/9/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "InstanceIDBindObject.h"

@implementation InstanceIDBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, IST_aPos, "a_beginPostion");
    glBindAttribLocation(program, IST_aColor, "a_color");
}
-(void)setUniformLocation:(GLuint)program{
    for (int i=0; i<25; i++) {
        NSString * str = [NSString stringWithFormat:@"u_offsets[%@]",@(i)];
        self->uniforms[IST_uniform_Offset+i] = glGetUniformLocation(program, str.UTF8String);
    }
}
-(NSString *)getShaderName{
    return @"InstanceID";
}

@end
