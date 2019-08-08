//
//  FlashlightSmoothBindObject.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/7.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "FlashlightSmoothBindObject.h"

@implementation FlashlightSmoothBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, BeginPosition, "beginPostion");
    glBindAttribLocation(program, FLM_BindAttribLocationNormal, "a_normal");
    glBindAttribLocation(program, FLM_BindAttribLocationTexture, "a_texture");
}

-(NSString *)getShaderName{
    return @"FlashlightSmooth";
}
@end
