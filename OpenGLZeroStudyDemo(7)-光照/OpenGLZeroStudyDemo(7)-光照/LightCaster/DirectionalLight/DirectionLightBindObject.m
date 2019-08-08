//
//  DirectionLightBindObject.m
//  OpenGLZeroStudyDemo(7)-光照
//
//  Created by glodon on 2019/8/7.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "DirectionLightBindObject.h"

@implementation DirectionLightBindObject
-(void)BindAttribLocation:(GLuint)program{
    glBindAttribLocation(program, BeginPosition, "beginPostion");
    glBindAttribLocation(program, DL_BindAttribLocationNormal, "a_normal");
    glBindAttribLocation(program, DL_BindAttribLocationTexture, "a_texture");
}

-(NSString *)getShaderName{
    return @"DirectionLight";
}
@end
