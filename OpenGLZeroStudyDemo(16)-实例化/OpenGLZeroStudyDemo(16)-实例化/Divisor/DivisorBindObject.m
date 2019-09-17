//
//  DivisorBindObject.m
//  OpenGLZeroStudyDemo(15)-高级Opengl-高级数据和高级glsl
//
//  Created by glodon on 2019/9/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "DivisorBindObject.h"

@implementation DivisorBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, DV_aPos, "a_beginPostion");
    glBindAttribLocation(program, DV_aColor, "a_color");
    glBindAttribLocation(program, DV_aOffset, "a_offset");
}

-(void)setUniformLocation:(GLuint)program{
   
}
-(NSString *)getShaderName{
    return @"Divisor";
}

@end
