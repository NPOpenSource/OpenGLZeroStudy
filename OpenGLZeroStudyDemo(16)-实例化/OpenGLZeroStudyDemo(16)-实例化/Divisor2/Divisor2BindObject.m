//
//  Divisor2BindObject.m
//  OpenGLZeroStudyDemo(15)-高级Opengl-高级数据和高级glsl
//
//  Created by glodon on 2019/9/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "Divisor2BindObject.h"

@implementation Divisor2BindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, DV2_aPos, "a_beginPostion");
    glBindAttribLocation(program, DV2_aColor, "a_color");
    glBindAttribLocation(program, DV2_aOffset, "a_offset");
}

-(void)setUniformLocation:(GLuint)program{
   
}
-(NSString *)getShaderName{
    return @"Divisor2";
}

@end
